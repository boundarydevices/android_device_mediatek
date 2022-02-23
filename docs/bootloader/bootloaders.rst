| This document details how to generate all the bootloader components for MediaTek boards:
| ``bl2.img``, ``fip.bin``, ``lk.bin``, ``u-boot.bin`` ...

Fetch projects
--------------

.. prompt:: bash $ auto

   $ mkdir bootloaders && cd $_
   $ repo init -u git@gitlab.com:mediatek/aiot/bsp/manifest.git -b rita/mtk-android-12 -m bootloaders.xml
   $ repo sync -c --no-tags --optimized-fetch --no-clone-bundle

Building
--------

All the scripts/configs used to build images can be found under ``build`` directory.

For now we support all these boards:

- i300a_pumpkin
- i350_evk
- i350_pumpkin
- i350_sb35
- i500_pumpkin

1. Install dependencies:

.. prompt:: bash $ auto

   $ sudo apt install bc bison build-essential curl flex git libssl-dev python3 python3-pip meson wget -y
   $ pip3 install pycryptodome pyelftools shyaml --user

2. Generate bootloaders images:

.. prompt:: bash $ auto

   $ cd bootloaders/
   $ ./build/build_all.sh --config=build/config/boards/i300a_pumpkin.yaml
   ...
   $ tree out/i300a_pumpkin/
   out/i300a_pumpkin/
   ├── debug
   │   ├── bl2-debug.img
   │   ├── fip_debug_ab.bin
   │   ├── fip_debug_noab.bin
   │   ├── lk-debug.bin
   │   ├── tee-debug.bin
   │   ├── u-boot-debug-ab.bin
   │   ├── u-boot-debug.bin
   │   ├── u-boot-initial-debug-env_ab
   │   └── u-boot-initial-debug-env_noab
   └── release
       ├── bl2-release.img
       ├── fip_release_ab.bin
       ├── fip_release_noab.bin
       ├── lk-release.bin
       ├── tee-release.bin
       ├── u-boot-initial-release-env_ab
       ├── u-boot-initial-release-env_noab
       ├── u-boot-release-ab.bin
       └── u-boot-release.bin

Each file can be generated separately, for more informations please look at the
`README.md <https://gitlab.com/mediatek/aiot/bsp/build-bootloaders>`_.

Flashing
--------

1. Download ``aiot-bootrom`` from `AIOT tools <https://mediatek.gitlab.io/aiot/bsp/aiot-tools/>`_.

2. Download the following files from `common <https://gitlab.com/mediatek/aiot/rita/device/mediatek/common>`__:

.. parsed-literal::

   mt8167/binaries/images/dl_addr.ini
   mt8167/binaries/images/lk.bin

3. Run ``aiot-bootrom``:

.. prompt:: bash $ auto

       $ aiot-bootrom
       INFO:aiot:Looking for a MediaTek SoC matching USB 0e8d:0003

4. press the *reset* and *volume up* buttons **simultaneously**

5. then release only the *reset* button

6. release the *volume up* button once you see that ``aiot-bootrom``
   returned successfully:

.. prompt:: bash $ auto

       $ aiot-bootrom
       INFO:aiot:Looking for a MediaTek SoC matching USB 0e8d:0003
       INFO:aiot:Opening /dev/ttyACM0 using baudate=115200
       INFO:aiot:Connected to MediaTek SoC
       INFO:aiot:Sending DA to address: 0x00201000
       INFO:aiot:Jumping to DA at address 0x00201000


7. Flash bl2:

.. prompt:: bash $ auto

       $ fastboot flash mmc0boot0 out/i300a_pumpkin/release/bl2-release.img

8. Flash fip:

.. prompt:: bash $ auto

       $ fastboot flash bootloaders out/i300a_pumpkin/release/fip_release_ab.bin

