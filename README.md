Pumpkin {#board_name}
=======

onyx is the device code name for mt8167 on Pumpkin board.

Get the code
------------

First, fetch the code with `aosp_install.sh` using `repo`:

``` {.sh}
mkdir ~/src/mediatek
git clone https://gitlab.com/baylibre/aosp/mediatek/manifest.git -b mtk-android-9
cd manifest
./aosp_install.sh android-9.0.0_r45 onyx ~/src/mediatek
```

`aosp_install` will take care of doing `repo init` and `repo sync`.

For more instructions about `repo`, please visit Android's official
documentation: https://source.android.com/setup/build/downloading

Additional dependencies
-----------------------

The flash/partitioning tools, which are generated at build time depend
on `pyyaml`. This can be installed with:

``` {.sh}
pip2 install --user pyyaml
```

Building
--------

For more build system related topics, see
[build\_system.md](./docs/build_system.md)

### {boot,system,vendor,cache,userdata,recovery}.img

Now, start the usual Android build setup:

``` {.sh}
cd ~/src/mediatek/
source build/envsetup.sh
lunch aosp_onyx-userdebug
make -j40
make out/target/product/onyx/dtbo.img
```

Note: to only rebuild a particular image, run `make <name>image`. For
example, for `vendor.img`:

``` {.sh}
make vendorimage -j40
```

### kernel

By default, Android uses a prebuild (binary) kernel located in:
`~/src/mediatek/device/mediatek/common-kernel/`

To re-build the kernel, have to perform the following steps:

1.  Fetch the kernel source code with `repo`:

``` {.sh}
mkdir ~/src/mediatek-kernel/ && cd $_
repo init -u https://gitlab.com/baylibre/aosp/mediatek/manifest.git -m kernel.xml -b mtk-android-9
repo sync
```

2.  Rebuild the kernel sources:

``` {.sh}
cd ~/src/mediatek-kernel/
DIST_DIR=~/src/mediatek/device/mediatek/common-kernel/ \
    BUILD_CONFIG=src/build.config.mtk \
    build/build.sh
```

DTB/DTBO Notes:

-   This also rebuilds the `dtbo.img`
-   Currently, the SoC device tree (`mt8167.dtb`) is also part of the
    `dtbo.img`. This will change when we re-partition.

3.  Finally, rebuild the Android Images to test the changes:

``` {.sh}
cd ~/src/mediatek/
source build/envsetup.sh
lunch aosp_onyx-userdebug
make -j40
make bootimage vendorimage out/target/product/onyx/dtbo.img
```

#### development tips

For incremental (faster) re-building the kernel, use the
`SKIP_MRPROPER=1` flag:

``` {.sh}
DIST_DIR=~/src/mediatek/device/mediatek/common-kernel/ \
    BUILD_CONFIG=src/build.config.mtk \
    SKIP_MRPROPER=1 \
    build/build.sh
```

To edit the kernel configuration (`make menuconfig`), use `build.sh`:

``` {.sh}
  BUILD_CONFIG=src/build.config.menuconfig.mtk \
  build/build.sh
```

Flashing
--------

Flashing is done using `flashimage.py` script. It requires `python2` and
the `pyserial` module which can be installed with:

``` {.sh}
pip2 install --user pyserial
```

### Flashing command

In order to fully flash the device, run the following command:

``` {.sh}
cd ~/src/mediatek/out/target/product/onyx/
python2 flashimage.py --update dtb_index 2 --update dtbo_index 3 --env-size 262144
```

Once you see *Waiting for DA mode*:

1)  press the *reset* and *volume up* buttons **simultaneously**
2)  then release only the *reset* button
3)  release the *volume up* button once you see that the image is
    getting flashed.
