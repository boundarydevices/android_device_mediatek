mt8183 EValuation Board (EVB) {#board_name}
=============================

Opal is the device code name for mt8183 on EVB board.

Get the code
------------

First, fetch the code with aosp_install.sh using `repo`:

``` {.sh}
mkdir ~/src/mediatek
git clone https://gitlab.com/baylibre/aosp/mediatek/manifest.git -b mtk-android-9
cd manifest
./aosp_install.sh android-9.0.0_r45 opal ~/src/mediatek/
```

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
lunch aosp_opal-userdebug
make -j40
make out/target/product/opal/dtbo.img
```

Note: to only rebuild a particular image, run `make <name>image`. For
example, for `vendor.img`:

``` {.sh}
make vendorimage -j40
```

### dtbo.img

To re-build the device tree overlay (dtbo) image, we can use `mkdtimg`:

``` {.sh}
mkdtimg create \
  ~/src/mediatek/device/mediatek/common-kernel/dtbo.img \
  ~/src/mediatek/device/mediatek/common-kernel/mt8183.dtb \
  ~/src/mediatek/device/mediatek/common-kernel/mt8183-evb.dtb
```

Notes:

-   Currently, the SoC device tree (`mt8183.dtb`) is also part of the
    `dtbo.img`. This will change when we re-partition.
-   This step is part of the kernel build scripts so does not need to be
    done manually.

### kernel

To re-build the kernel, we can do the following:

``` {.sh}
cd ~/src/mediatek/
source build/envsetup.sh
lunch aosp_opal-userdebug
cd kernel
DIST_DIR=$ANDROID_BUILD_TOP/device/mediatek/common-kernel/ \
    BUILD_CONFIG=src/build.config.mtk \
    build/build.sh
```

Note that this is *optional*, as some prebuild kernel binaries are
available in: `src/mediatek/device/mediatek/common-kernel/`

To incrementally re-build the kernel, for development, use the
`SKIP_MRPROPER=1` option:

``` {.sh}
DIST_DIR=$ANDROID_BUILD_TOP/device/mediatek/common-kernel/ \
    BUILD_CONFIG=src/build.config.mtk \
    SKIP_MRPROPER=1 \
    build/build.sh
```

To edit the kernel configuration, we can also use `build.sh`:

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
cd ~/src/mediatek/out/target/product/opal/
python2 flashimage.py --update dtbo_index 1 --update dtb_index 0 --env-size 262144
```

Once you see *Waiting for DA mode*:

1)  press the *reset* and *volume up* buttons **simultaneously**
2)  then release only the *reset* button
3)  release the *volume up* button once you see that the image is
    getting flashed.

Tips
----

### stay awake

As soon as the device boots, the screen will go off and it will go into
suspend. When that happens, the UART console is blocked as well.

To avoid that, you can tell the power manager to stay awake:

``` {.sh}
svc power stayon true
```

Alternatively, you can hold a wakelock via the commandline:

``` {.sh}
echo lock_me > /sys/power/wake_lock
echo lock_me > /sys/power/wake_unlock
```
