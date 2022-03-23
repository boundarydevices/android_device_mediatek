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
   $ ./build/build_all.sh --config=build/config/boards/i350_sb35.yaml
   ...
   $ tree out/i350_sb35/
   out/i350_sb35/
   └── release
       ├── bl2-release.img
       ├── fip_release.bin
       ├── lk-release.bin
       ├── tee-release.bin
       ├── u-boot-initial-release-env
       └── u-boot-release.bin

By default the build is incremental, if you want to build from clean state please add ``--clean`` argument to the command line.

3 build modes are supported: **release** (default), **debug** and **factory**.

The mode can be specified by adding the argument ``--mode=debug``.

Each file can be generated separately, for more informations please look at the
`README.md <https://gitlab.com/mediatek/aiot/bsp/build-bootloaders>`_.

Flashing
--------

1. Download ``aiot-bootrom`` from `AIOT tools <https://mediatek.gitlab.io/aiot/bsp/aiot-tools/>`_.

2. Move the download agent (``lk.bin``) in the same directory:

.. prompt:: bash $ auto

   $ cp out/i350_sb35/release/lk-release.bin lk.bin

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

   $ fastboot flash mmc0boot0 out/i350_sb35/release/bl2-release.img

8. Flash fip:

.. prompt:: bash $ auto

   $ fastboot flash bootloaders out/i350_sb35/release/fip_release.bin

