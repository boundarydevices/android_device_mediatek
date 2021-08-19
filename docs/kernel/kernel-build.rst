Android is built around a Linux kernel. By default, Android's
``boot.img`` is build from a binary kernel Image located in::

   ~/src/rita/device/mediatek/kernel-binaries/5.4

This guide describes how to rebuild and customize a Linux kernel for
Android.

Fetching the kernel code
------------------------

Fetch the code using ``repo``:

.. prompt:: bash $

   mkdir ~/src/rita-kernel/ && cd $_
   repo init -u git@gitlab.com:mediatek/aiot/bsp/manifest.git -b rita/mtk-android-11 -m kernel-5.4.xml
   repo sync

.. note::

   For folks who have signed an NDA with MediaTek, some additional projects are
   available. Use the following command instead:


   .. prompt:: bash $

     mkdir ~/src/rita && cd $_
     repo init -u git@gitlab.com:mediatek/aiot/bsp/manifest.git -b rita/mtk-android-11 -m kernel-5.4_rita_restricted.xml
     repo sync


Building the kernel
-------------------

In this section, we will assume that we already have an Android source
tree which has been fully build and is located in:

.. prompt:: bash $

  ~/src/rita/

Build everything from scratch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. prompt:: bash $

   cd ~/src/rita-kernel/
   export DIST_DIR=~/src/rita/device/mediatek/kernel-binaries/5.4
   export BUILD_CONFIG=src/build.config.mtk
   build/build.sh

Rebuilding incrementally
~~~~~~~~~~~~~~~~~~~~~~~~

Add the ``SKIP_MRPROPER=1`` flag:

.. prompt:: bash $

   cd ~/src/rita-kernel/
   export DIST_DIR=~/src/rita/device/mediatek/kernel-binaries/5.4
   export BUILD_CONFIG=src/build.config.mtk
   export SKIP_MRPROPER=1
   build/build.sh

Defconfig/menuconfig changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The usual (``make menuconfig``) is done via ``config.sh``:

.. prompt:: bash $

   cd ~/src/rita-kernel/
   export BUILD_CONFIG=src/build.config.mtk
   build/config.sh

Rebuilding all involved Android images
--------------------------------------

To test the kernel changes, we have to re-generate the relevant Android
images:

-  ``boot.img``: contains the kernel binary and the main device tree
-  ``vendor.img``: contains the kernel modules
-  ``dtbo.img``: contains the device tree overlays

To rebuild the Android images, do:

.. prompt:: bash $

   cd ~/src/rita/
   source build/envsetup.sh
   lunch $LUNCH_TARGET
   make bootimage vendorimage $(get_build_var PRODUCT_OUT)/dtbo.img

Where ``$LUNCH_TARGET`` is listed in :ref:`getting-started/README:supported boards`

Flashing the kernel
-------------------

.. prompt:: bash $

   cd $ANDROID_PRODUCT_OUT
   adb reboot fastboot
   fastboot flash boot boot.img
   fastboot flash vendor vendor.img
   fastboot flash dtbo dtbo.img
   fastboot reboot

