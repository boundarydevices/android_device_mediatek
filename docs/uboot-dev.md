U-Boot development guide
========================

This documents details how to the bootloader, "Das U-Boot" for
mt8183 EValuation Board (EVB)

Fetch the source
----------------

``` {.sh}
mkdir ~/src/u-boot-mediatek
git clone https://gitlab.com/baylibre/rich-iot/u-boot.git -b mtk-v2019.07-android-dev ~/src/u-boot-mediatek && cd $_
```

Build and integrate into Android
--------------------------------

1.  install the .config:

``` {.sh}
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make mt8183_evb_android_defconfig
```

2.  Build the `u-boot.bin` binary:

``` {.sh}
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make
```

3.  Export the output to Android source tree: This requires `fiptool` to
    be installed.

`fiptool` can be build from source from the following repo:
https://github.com/ARM-software/arm-trusted-firmware/tree/master/tools/fiptool

``` {.sh}
# this exports the initial U-Boot environment variables (stored in eMMC)
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- scripts/get_default_envs.sh  > \
    ~/src/mediatek/device/mediatek/common/soc/mt8183/binaries/images/u-boot-initial-env

# this updates the firmware package binary which contains other binaries such as bl2
fiptool update \
    ~/src/mediatek/device/mediatek/common/soc/mt8183/binaries/images/fip.bin \
    --nt-fw u-boot.bin'
```

Flash
-----

In order to reflash U-Boot for Android, we first need to install the
files in `out` folder:

``` {.sh}
cd ~/src/mediatek/
source build/envsetup.sh
lunch aosp_opal-userdebug
make out/target/product/opal/fip.bin \
     out/target/product/opal/u-boot-initial-env
```

Then, we can reflash the bootloader and linux kernel with:

``` {.sh}
cd ~/src/mediatek/out/target/product/opal/
python2 flashimage.py --boot --update dtbo_index 1
```

Once you see *Waiting for DA mode*:

1)  press the *reset* and *volume up* buttons **simultaneously**
2)  then release only the *reset* button
3)  release the *volume up* button once you see that the image is
    getting flashed.
