RITA (Rich IoT Android) provides an AOSP experience on the MediaTek
Pumpkin boards.

.. note::

    Please make sure the power supply (usb port or specific port) is sufficient for the board.
    Use powered usb hub instead of direct connection to the usb port of the pc or the laptop.


Supported boards
================

============== =========================
Name           Android lunch target
============== =========================
Pumpkin i300a  ``i300a_pumpkin-userdebug``
Pumpkin i350   ``i350_pumpkin-userdebug``
Pumpkin i500   ``i500_pumpkin-userdebug``
Innocomm SB30  ``i300a_sb30-userdebug``
Innocomm SB35  ``i350_sb35-userdebug``
AIoT i350 EVK  ``i350_evk-userdebug``
============== =========================


Fetching the code
=================

Fetch the code using ``repo``:

.. prompt:: bash $

   mkdir ~/src/rita && cd $_
   repo init -u git@gitlab.com:mediatek/aiot/bsp/manifest.git -b rita/mtk-android-11
   repo sync

.. note::

   For folks who have signed an NDA with MediaTek, some additional projects are
   available. Use the following command instead:


   .. prompt:: bash $

     mkdir ~/src/rita && cd $_
     repo init -u git@gitlab.com:mediatek/aiot/bsp/manifest.git -b rita/mtk-android-11 -m rita_restricted.xml
     repo sync

For more information about ``repo``, visit `Android's official
documentation <https://source.android.com/setup/build/downloading>`__


Building
========

Setup
-----

Refer to:

-  `Android's Build
   requirements <https://source.android.com/setup/build/requirements>`__.
-  `Android's Establishing a Build
   Environment <https://source.android.com/setup/build/initializing>`__
   guide.

Then, install ``pyyaml`` for python3:

.. prompt:: bash $

   pip3 install --user pyyaml

``pyyaml`` is used by our partitioning tools, which are called at build
time.

Building Android
----------------

.. prompt:: bash $

   cd ~/src/rita/
   source build/envsetup.sh
   lunch $LUNCH_TARGET
   m -j40

Where ``$LUNCH_TARGET`` is listed in `Supported boards`_


We also support the following build flags to enable optional features:

-  ``TARGET_AVB_ENABLE=true`` : Enable
   `AVB <https://source.android.com/security/verifiedboot/avb>`__
-  ``TARGET_USE_AB_SLOT=true`` : Enable `AB
   partitions <https://source.android.com/devices/tech/ota/ab>`__
-  ``TARGET_VKMS_ENABLED=true`` : Enable Virtual Display


Rebuilding the Linux kernel
---------------------------

By default, Android's kernel is build from a prebuilt binary located in::

   ~/src/rita/device/mediatek/kernel-binaries/5.4

To re-build the kernel, refer to :ref:`kernel/kernel-build:building the kernel`


Flashing
========

Prerequisites
-------------

Flashing is done via the `AIOT tools <https://mediatek.gitlab.io/aiot/bsp/aiot-tools/>`_.

.. note::

    AIOT tools was originally developped for yocto, but it supports Android (RITA) as well.

Please follow the `AIOT tools manual <https://mediatek.gitlab.io/aiot/bsp/aiot-tools>`_
for instructions on how to install the tools.


Flashing everything
-------------------

To fully flash the board, run the following:

.. prompt:: bash $

   cd ~/src/rita/out/target/product/i300a_pumpkin/
   aiot-flash

Once you see *Waiting for DA mode*:

1) press the *reset* and *volume up* buttons **simultaneously**
2) then release only the *reset* button
3) release the *volume up* button once you see that the image is getting
   flashed.

.. note::

    For Innocomm SB-35 and Pumpkin i350 boards, use the *volume down* button
    instead of the *volume up* button.

Peripheral support
==================

By default, the Pumpkin boards have no external peripheral support.
Additional hardware can be enabled via Device-Tree Overlays (DTBO).

To enable one of the below DTBOs, modify the ``dtbo_index`` at flashing
time by passing the ``--update dtbo_index <dtbo_index>`` argument:

.. prompt:: bash $

  cd ~/src/rita/out/target/product/i300a_pumpkin/
  aiot-flash --dtbo-index <dtbo_index>

.. note::
    To avoid reflashing, It's possible to change the ``dtbo_index`` from the U-Boot shell.
    For example:

    .. prompt:: u-boot =>

       env set dtbo_index 1
       saveenv
       reset


Pumpkin i300a
-------------

The following Device-Tree Overlays are supported:

========== =========================
dtbo_index description
========== =========================
0          HDMI only
1          Raspberri Pi 7" DSI panel
2          Audio I2s on the 40pins header (disables SD card)
3          OV5645 camera sensor
========== =========================

Pumpkin i350
------------

The following Device-Tree Overlays are supported:

========== =========================
dtbo_index description
========== =========================
0          HDMI only
========== =========================

Pumpkin i500
------------

The following Device-Tree Overlays are supported:

========== ================================================
dtbo_index description
========== ================================================
0          HDMI only
1          UMO-9465MD-T DSI panel
2          Single Onsemi AR0330 camera sensor
3          Dual AR0330 camera sensors
4          Single Onsemi AP1302 ISP + Single AR0330
5          Single AP1302 ISP + Single Onsemi AR0144 sensor
6          Single AP1302 ISP + Dual AR0144
7          Dual AP1302 ISPs + Single AR0144 + Single AR0330
8          Dual AP1302 ISPs + Dual AR0144 + Single AR0330
========== ================================================

Innocomm SB35
-------------

The following Device-Tree Overlays are supported:

========== =========================
dtbo_index description
========== =========================
0          HDMI only
1          Raspberri Pi 7" DSI panel
========== =========================

AIoT i350 EVK
-------------

The following Device-Tree Overlays are supported:

========== =========================
dtbo_index description
========== =========================
0          HDMI only
1          Startek KD070FHFID015 DSI panel Only
========== =========================

.. warning::
   Please check Switch (SW2101) position on Board to select DPI, same as image
   
   .. image:: images/i350_dpi_lan_switch.jpg
      :width: 350


Multiple DTBOs
--------------

To enable multiple DTBOs, pass a space-separated index list. For
example, to enable both ``UMO-9465MD-T DSI panel`` (1) and
``Onsemi AR0330CS camera sensor + Onsemi AP1302 ISP`` (3), run:

.. prompt:: bash $

  aiot-flash --dtbo-index '1 4'

The overlays are applied in the order documented in `Validating the DTBO
partition <https://source.android.com/devices/architecture/dto/compile#validating-the-dtbo-partition>`__
