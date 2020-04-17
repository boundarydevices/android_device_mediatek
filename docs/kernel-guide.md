Android Linux kernel development guide
======================================

Android is built around a Linux kernel. By default, Android's `boot.img`
is build from a binary kernel Image located in:

    ~/src/mediatek/device/mediatek/common-kernel/

This guide describes how to rebuild and customize a Linux kernel for
Android.

Fetching the kernel code
------------------------

Fetch the code using `repo`:

    $ mkdir ~/src/mediatek-kernel/ && cd $_
    $ repo init -u https://gitlab.com/baylibre/aosp/mediatek/manifest.git -m kernel.xml -b mtk-android-9
    $ repo sync

Building the kernel
-------------------

In this section, we will assume that we already have an Android source
tree which has been fully build and is located in:

    $ ~/src/mediatek/

### Build everything from scratch

    $ cd ~/src/mediatek-kernel/
    $ DIST_DIR=~/src/mediatek/device/mediatek/common-kernel/ \
        BUILD_CONFIG=src/build.config.mtk \
        build/build.sh

### Rebuilding incrementally

Add the `SKIP_MRPROPER=1` flag:

    $ cd ~/src/mediatek-kernel/
    $ DIST_DIR=~/src/mediatek/device/mediatek/common-kernel/ \
        BUILD_CONFIG=src/build.config.mtk \
        SKIP_MRPROPER=1 \
        build/build.sh

### Defconfig/menuconfig changes

The usual (`make menuconfig`) is done via `build.sh`:

    $ cd ~/src/mediatek-kernel/
    $ BUILD_CONFIG=src/build.config.menuconfig.mtk \
      build/build.sh

Rebuilding all involved Android images
--------------------------------------

To test the kernel changes, we have to re-generate the relevant Android
images:

-   `boot.img`: contains the kernel binary and all the built-in modules
-   `vendor.img`: contains the kernel modules
-   `dtbo.img`: contains both the main device tree and the device tree
    overlays

To rebuild the Android images, do:

    $ cd ~/src/mediatek/
    $ source build/envsetup.sh
    $ lunch aosp_onyx-userdebug
    $ make bootimage vendorimage out/target/product/onyx/dtbo.img vbmetaimage

Flashing the kernel
-------------------

    $ cd ~/src/mediatek/out/target/product/onyx/
    $ python2 ./flashimage.py --boot --update dtb_index 2 --update dtbo_index 3 --env-size 262144

Building the kernel without and Android environment
---------------------------------------------------

In this section, we will cover how to rebuild an Android kernel without
needing the Android source tree. This is done by:

1.  Downloading prebuild images
2.  Re-injecting the kernel binaries into those images.

### Additional dependencies

    $ apt-get install android-tools-fsutils e2tools

### Prebuild images

Prebuild Android images are available via BayLibreCI at [nightly
builds](http://build3.baylibre.com/builds/nightly/).

Download the images for onyx to `<path/to/android/images>`.

For more information about BayLibreCI, see [the source
code](https://gitlab.com/baylibre/baylibre-ci/-/tree/master/src).

### Build everything from scratch

    $ cd ~/src/mediatek-kernel/
    $ BUILD_CONFIG=src/build.config.mtk \
      IN_KERNEL_MODULES=1 \
      MKBOOTIMG_PATH=system/core/mkbootimg/mkbootimg \
      UNPACK_BOOTIMG_PATH=system/core/mkbootimg/unpack_bootimg \
      PREBUILT_DIR=<path/to/android/images> \
      build/build.sh

### Reflashing the images

    $ adb reboot bootloader
    $ fastboot flash vendor vendor.img && fastboot flash boot boot.img && fastboot flash dtbo dtbo.img
    $ fastboot reboot
