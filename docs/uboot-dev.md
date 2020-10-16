U-Boot development guide
========================

This documents details how to build and flash the bootloader, "Das
U-Boot" for Pumpkin i300A

Fetch the source
----------------

    $ mkdir ~/src/u-boot-mediatek
    $ git clone https://gitlab.com/baylibre/rich-iot/u-boot.git -b mtk-v2019.10 ~/src/u-boot-mediatek && cd $_

Build and integrate into Android
--------------------------------

The bootloader can be build in two flavors:

1.  Traditional (legacy) OTA support
2.  A/B support

### Prerequisites

#### fiptool

`fiptool` can be build from source from the following repo:
https://github.com/ARM-software/arm-trusted-firmware/tree/master/tools/fiptool

### Building for traditional (legacy) OTA support

Install the `.config`:

    $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make pumpkin_android_defconfig

Build the `u-boot.bin` binary:

    $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make

Export the `fip.bin` binary to Android source tree:

    $ # this updates the firmware package binary which contains other binaries such as bl2
    $ fiptool update \
        ~/src/mediatek/device/mediatek/common/soc/mt8167/binaries/images/fip_noab.bin \
        --nt-fw u-boot.bin'

Export the U-boot initial environment to the Android source tree:

    $ # this exports the initial U-Boot environment variables (stored in eMMC)
    $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- scripts/get_default_envs.sh  > \
        ~/src/mediatek/device/mediatek/common/soc/mt8167/binaries/images/u-boot-initial-env_noab

### Building for A/B OTA support

Install the `.config`:

    $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make pumpkin_android_ab_defconfig

Build the `u-boot.bin` binary:

    $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make

Export the `fip.bin` binary to Android source tree:

    $ # this updates the firmware package binary which contains other binaries such as bl2
    $ fiptool update \
        ~/src/mediatek/device/mediatek/common/soc/mt8167/binaries/images/fip_ab.bin \
        --nt-fw u-boot.bin'

Export the U-boot initial environment to the Android source tree:

    $ # this exports the initial U-Boot environment variables (stored in eMMC)
    $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- scripts/get_default_envs.sh  > \
        ~/src/mediatek/device/mediatek/common/soc/mt8167/binaries/images/u-boot-initial-env_ab

Flash
-----

In order to reflash U-Boot for Android, we first need to install the
files in `out` folder:

    $ cd ~/src/mediatek/
    $ source build/envsetup.sh
    $ lunch aosp_onyx-userdebug
    $ make out/target/product/onyx/fip.bin \
        out/target/product/onyx/u-boot-initial-env

Then, we can reflash the bootloader and linux kernel with:

    $ cd ~/src/mediatek/out/target/product/onyx/
    $ ./flashimage.py --boot

Once you see *Waiting for DA mode*:

1)  press the *reset* and *volume up* buttons **simultaneously**
2)  then release only the *reset* button
3)  release the *volume up* button once you see that the image is
    getting flashed.
