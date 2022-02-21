Secure Boot
===========

Secure boot is a mechanism that establishes a Chain of Trust (CoT) on all system boot images.
Secure boot relies on cryptography to verify image signatures before their execution.

This document explain how to secure each boot transition.

Building secure images
----------------------

The secure images are generated when we pass the argument ``--mode=factory``.

.. parsed-literal::

   $ cd bootloaders
   $ ./build/build_all.sh --config=build/config/boards/i300a_pumpkin.yaml --mode=factory --clean
   ...
   $ tree out/i300a_pumpkin/
   out/i300a_pumpkin/
   └── factory
       ├── bl2-factory.img
       ├── fip_factory_ab.bin
       ├── fip_factory_noab.bin
       ├── lk-factory.bin
       ├── tee-factory.bin
       ├── u-boot-factory-ab.bin
       ├── u-boot-factory.bin
       ├── u-boot-initial-factory-env_ab
       └── u-boot-initial-factory-env_noab

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

This section is not documentation as the feature is not implement yet.

Secure: BL2 to fip images
-------------------------

The BL2 image contains an RSA public key and will use it to verify fip images (signed with the private key).

By default the private key used is located under: ``build/.keys/rot_keys.pem``

If the user did not provide the private key, the scripts generate a new one.

To generate own private key:

.. prompt:: bash $ auto

   $ cd bootloaders/build/.keys
   $ openssl genrsa -out rot_key.pem 2048

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
