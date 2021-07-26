U-Boot development guide
========================

This documents details how to build and flash the bootloader, "Das
U-Boot" for Pumpkin i300a

Fetch the source
----------------

.. prompt:: bash $

   mkdir ~/src/u-boot-mediatek
   git clone https://gitlab.com/baylibre/rich-iot/u-boot.git -b mtk-v2021.04 ~/src/u-boot-mediatek && cd $_

Build and integrate into Android
--------------------------------

The bootloader can be build in two flavors:

1. Traditional (legacy) OTA support
2. A/B support

Prerequisites
~~~~~~~~~~~~~

fiptool
^^^^^^^

``fiptool`` can be build from source from the following repo:
`https://github.com/ARM-software/arm-trusted-firmware/tree/master/tools/fiptool <https://github.com/ARM-software/arm-trusted-firmware/tree/master/tools/fiptool>`__

Building for OTA support
~~~~~~~~~~~~~~~~~~~~~~~~

Install the ``.config``:

.. prompt:: bash $

   ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make mt8516_pumpkin_android_defconfig

Build the ``u-boot.bin`` binary:

.. prompt:: bash $

   ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make

Export the ``fip.bin`` binary to Android source tree:

* For Legacy OTA

 .. prompt:: bash $

    # this updates the firmware package binary which contains other binaries such as bl2
    fiptool update \
      ~/src/rita/device/mediatek/common/soc/mt8167/binaries/images/fip_noab.bin \
      --nt-fw u-boot.bin

* For A/B Slot

 .. prompt:: bash $

    # this updates the firmware package binary which contains other binaries such as bl2
    fiptool update \
      ~/src/rita/device/mediatek/common/soc/mt8167/binaries/images/fip_ab.bin \
      --nt-fw u-boot.bin


Export the U-boot initial environment to the Android source tree:

* For Legacy OTA

 .. prompt:: bash $

    # this exports the initial U-Boot environment variables (stored in eMMC)
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- scripts/get_default_envs.sh  > \
      ~/src/rita/device/mediatek/common/soc/mt8167/binaries/images/u-boot-initial-env_noab

* For A/B Slot

 .. prompt:: bash $

    # this exports the initial U-Boot environment variables (stored in eMMC)
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- scripts/get_default_envs.sh  > \
      ~/src/rita/device/mediatek/common/soc/mt8167/binaries/images/u-boot-initial-env_ab

Flash
-----

In order to reflash U-Boot for Android, we first need to install the
files in ``out`` folder:

.. prompt:: bash $

   cd ~/src/rita/
   source build/envsetup.sh
   lunch i300a_pumpkin-userdebug


* For Legacy OTA

 .. prompt:: bash $

    make out/target/product/i300a_pumpkin/fip.bin out/target/product/i300a_pumpkin/u-boot-initial-env

* For A/B Slot

 .. prompt:: bash $

    TARGET_USE_AB_SLOT=true make out/target/product/i300a_pumpkin/fip.bin out/target/product/i300a_pumpkin/u-boot-initial-env

Then, we can reflash the bootloaders:

.. prompt:: bash $

   cd ~/src/rita/out/target/product/i300a_pumpkin/
   rity-flash mmc0boot0 mmc0boot1 bootloaders

Once you see *Waiting for DA mode*:

1) press the *reset* and *volume up* buttons **simultaneously**
2) then release only the *reset* button
3) release the *volume up* button once you see that the image is getting
   flashed.
