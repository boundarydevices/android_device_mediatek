Secure Boot
===========

Secure boot is a mechanism that establishes a Chain of Trust (CoT) on all system boot images.
Secure boot relies on cryptography to verify image signatures before their execution.

This document explain how to secure each boot transition.

Building secure images
----------------------

The secure images and package are generated when we pass the argument ``--mode=factory``.

.. prompt:: bash $ auto

   $ cd bootloaders
   $ ./build/build_all.sh --config=buid/config/boards/i350_sb35.yaml --mode=factory --clean
   ...
   $ tree out/i350_sb35/
   out/i350_sb35/
   └── factory
       ├── bl2-factory.img
       ├── fip_factory.bin
       ├── lk-factory.bin
       ├── lk-factory.sign
       ├── secure_i350_sb35.zip
       ├── tee-factory.bin
       ├── u-boot-factory.bin
       └── u-boot-initial-factory-env

   $ unzip -Z1 out/i350_sb35/factory/secure_i350_sb35.zip
   rot_key.pem
   avb.pem
   avb_pub.pem
   efuse.xml
   efuse.pem
   i350_sb35_android_scatter.txt
   i350_sb35_preloader.bin
   da.pem
   MTK_AllInOne_DA_signed.bin
   auth_sv5.auth

+-----------------+------------------------------------------------------------------------+
| Security Keys   | Description                                                            |
+=================+========================================================================+
| ``efuse.pem``   | Private key used to sign BL2 image and update efuse (public key field) |
+-----------------+------------------------------------------------------------------------+
| ``da.pem``      | Private key used for Download Agent Authentication                     |
+-----------------+------------------------------------------------------------------------+
| ``rot_key.pem`` | Private key used by BL2 to verify fip images                           |
+-----------------+------------------------------------------------------------------------+
| ``avb.pem``     | Private key used by Android to sign images                             |
+-----------------+------------------------------------------------------------------------+
| ``avb_pub.pem`` | Public key used by U-Boot to verify Android images                     |
+-----------------+------------------------------------------------------------------------+

.. warning::

   By default on factory mode, OP-TEE (BL32 in fip binary) is built with this flag:

   - ``CFG_RPMB_WRITE_KEY``:

     This flag configure the RPMB if this one is not initialized yet.

     This operation is performed one time only, once the RPMB is initialized with the key we cannot override it anymore.

.. note::

   **RPMB corruptions**:

   If we do several flash with different build, we may be faced to RPMB corruptions.

   Indeed some metadata are stored in the RPMB and by default if there is a mismatch OP-TEE fail to load Trusted Applications.

   Thus OP-TEE keymaster service failed and the device doesn't boot.

   To avoid this situation we can add the flag ``CFG_REE_FS_ALLOW_RESET=y`` in `build_optee.sh`::

     Allow secure storage in the REE FS to be entirely deleted without causing anti-rollback errors.
     This is used to reset the secure storage to a clean, empty state.

Secure: BL1 to BL2
------------------

When we power-up the device, the BL1 (ROM code) is the first code run.
This code cannot be modified, however we can enable several features through efuse settings.

When we run ``build_all.sh`` in factory mode, we generate all the necessary files to support:

- Secure Boot Check (SBC): verify BL2 in "normal" mode
- Download Agent Authentication (DAA): verify DA in download mode (eg ``aiot-flash``)

If SBC is not supported by a target, a warning message is displayed at the compilation, the BL2 image is not signed and the BL1 doesn't verify BL2.

If DAA is not supported by a target, a warning message is displayed at the compilation, the Download Agent (``lk``) is not signed and verified when we are in download mode (eg ``aiot-flash``).

1. Build all in factory mode

.. prompt:: bash $ auto

   $ cd bootloaders
   $ ./build/build_all.sh --config=buid/config/boards/i350_sb35.yaml --mode=factory --clean

The keys used for SBC and DAA are added in the secure package and located by default under: ``build/.keys/efuse.pem`` and ``build/.keys/da.pem``

To generate own private key:

.. prompt:: bash $ auto

   $ cd bootloaders/build/
   $ ./secure.sh generate_efuse_key
   $ ./secure.sh generate_da_key

.. warning::

   Enable SBC/DAA and write the public key in efuse are performed one time only.

   The efuse will be blown forever, we cannot override these fields after that.

   The private keys ``efuse.pem`` and ``da.pem`` **MUST NOT BE LOST**.

   Otherwise we won't be able to sign/boot ``bl2.img`` and Download Agent (download mode).

2. Download ``SP_Flash_Tool_v5.2016_Win.zip`` for Windows

``SP_Flash_Tool`` is a mediatek tools used to write efuse settings.

https://online.mediatek.com/English/Tool

3. Extract ``SP_Flash_Tool_v5.2016_Win.zip``

4. Extract all the files from secure_i350_sb35.zip into ``SP_Flash_Tool_v5.2016_Win`` folder

5. Check current efuse settings on the device:

.. prompt:: bash $ auto

   C:\Users\julien\SP_Flash_Tool_v5.2016_Win> flash_tool.exe -o -i efuse.xml

If the device doesn't have SBC and DAA enabled, these fields should not be set:

- ``sbc_en = off``
- ``daa_en = off``
- ``sbc_pub_key_hash = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000``

6. Write public key and enable SBC/DAA:

.. prompt:: bash $ auto

   C:\Users\julien\SP_Flash_Tool_v5.2016_Win> flash_tool.exe -i efuse.xml

7. Read back efuse settings:

.. prompt:: bash $ auto

   C:\Users\julien\SP_Flash_Tool_v5.2016_Win> flash_tool.exe -o -i efuse.xml

These fields should now be updated:

- ``sbc_en = on``
- ``daa_en = on``
- ``sbc_pub_key_hash = XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX``

In this step DAA is enabled, when we read efuse setting we load/verify/boot the Download Agent.

8. Flash ``bl2.img`` with aiot-bootrom:

.. prompt:: bash $ auto

   $ unzip -j secure_i350_sb35.zip auth_sv5.auth
   $ aiot-bootrom -b lk-factory.bin -s lk-factory.sign
   $ fastboot flash mmc0boot0 bl2-factory.img

Secure: BL2 to fip images
-------------------------

The BL2 image contains an RSA public key and will use it to verify fip images (signed with the private key).

By default the private key used is located under: ``build/.keys/rot_key.pem``

If the user did not provide the private key, the scripts generate a new one.

To generate own private key:

.. prompt:: bash $ auto

   $ cd bootloaders/build/
   $ ./secure.sh generate_rot_key

The user can also specified the absolute path of the rot key in yaml config:

.. code-block:: yaml

   secure:
     rot_key: /home/julien/Documents/mediatek/rot_key.pem

If the fip images is not signed or signed with another key, BL2 will detect it and rise this kind of errors: (baudrate 115200)::

   [EMI] mcp_dram_num:0,discrete_dram_num:1,enable_combo_dis:0
   [EMI] MDL number = 0
   [MEM] complex R/W mem test pass
   ERROR:   BL2: Failed to load image id 3 (-2)

Android Verified Boot (AVB)
---------------------------

Source:
https://android.googlesource.com/platform/external/avb/+/master/README.md

Boot verification
^^^^^^^^^^^^^^^^^

U-Boot contains the AVB public key used to verify boot partition through vbmeta informations.

When we build Android with ``TARGET_AVB_ENABLE := true``, we generate ``vbmeta.img`` which contains informations (SHA256) of the boot image.

By default ``vbmeta.img`` is signed with the private key ``external/avb/test/data/testkey_rsa4096.pem`` and the corresponding public test key is already present in U-Boot project: ``default.avbpubkey``.

If the user doesn't specify key pair public (U-Boot) / private (Android), the default test keys are used.

However it's possible to use own keys:

1. Generate public/private keys

.. prompt:: bash $ auto

   $ cd bootloaders/build/
   $ ./secure.sh generate_avb_keys

That will generate ``avb_priv.pem`` and  ``avb_pub.pem`` under ``build/.keys``.

The bootloaders scripts will detect that ``avb_pub.pem`` is present and will include it into U-Boot.

The user can also specified the absolute path of the avb_pub key in yaml config:

.. code-block:: yaml

   secure:
     avb_pub_key: /home/julien/Documents/mediatek/avb_pub.pem


2. Use ``avb_priv.pem`` in Android

.. prompt:: bash $ auto

   # copy AVB private key to AOSP
   $ cp .keys/avb_priv.pem "${ANDROID_BUILD_TOP}/device/mediatek/common/"

Add the following configs in ``device/mediatek/common/BoardConfigCommon.mk``::

   BOARD_AVB_ALGORITHM := SHA256_RSA4096
   BOARD_AVB_KEY_PATH := device/mediatek/common/avb_priv.pem

Typical errors raised by U-Boot:

- ``vbmeta.img`` signed with another key::

   avb_slot_verify.c:837: ERROR: vbmeta_a: Public key used to sign data rejected.

- ``boot.img`` hash different than the one specified in ``vbmeta.img``::

   avb_slot_verify.c:428: ERROR: boot_a: Hash of data does not match digest in descriptor.

System and Vendor verifications
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Not yet supported, some changes are needed:
https://source.android.com/devices/tech/ota/dynamic_partitions/implement#avb-configuration-changes
