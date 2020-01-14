Release checklist
=================

Tests we need to run before releasing to a customer.

Fetching/building release
-------------------------

NOTE: all instructions should come from the device's README available
at:

``` {.sh}
~/src/mediatek/device/mediatek/onyx/README.md
```

-   \[ \] repo init
-   \[ \] repo sync
-   \[ \] lunch
-   \[ \] can build full Android image for lunch target
-   \[ \] can flash from `out` folder for lunch target
-   \[ \] hardware is flashed and boots to home screen

Kernel rebuilding
-----------------

NOTE: all instructions should come from the device's README available
at:

``` {.sh}
~/src/mediatek/device/mediatek/onyx/docs/kernel-guide.md
```

-   \[ \] we can clean (full) rebuild the kernel
-   \[ \] we can incrementally rebuild the kernel
-   \[ \] we can re-generate `dtbo.img`
-   \[ \] we can edit the kernel `menuconfig` via script / helper
-   \[ \] we can flash the new kernel(`{boot,dtbo.vendor}.img`)
-   \[ \] hardware is flashed and boots to home screen

Connectivity tests
------------------

### WiFi

-   \[ \] Wifi can scan for access points
-   \[ \] Wifi regulation is supported (`iw set reg`/`iw get reg`)

``` {.sh}
# iw reg get
global
country 00: DFS-UNSET
        (2402 - 2472 @ 40), (N/A, 20), (N/A)
        (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
        (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
        (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
        (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
        (57240 - 63720 @ 2160), (N/A, 0), (N/A)
# iw reg set FR
# iw reg get
global
country FR: DFS-ETSI
        (2402 - 2482 @ 40), (N/A, 20), (N/A)
        (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
        (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
        (5470 - 5725 @ 160), (N/A, 27), (0 ms), DFS
        (5725 - 5875 @ 80), (N/A, 13), (N/A)
        (57000 - 66000 @ 2160), (N/A, 40), (N/A)
```

### Bluetooth

-   \[ \] Bluetooth can scan for peripherals

Display / Touch tests
---------------------

### Display

-   \[ \] Brightness control

``` {.sh}
# input keyevent 220
brightness decreases
```

``` {.sh}
# input keyevent 221
brightness increases
```

-   \[ \] Splashscreen (in bootloader) support

### Touch

-   \[ \] taps are detected

``` {.sh}
# getevent -lp
we see a touch input
```

``` {.sh}
# getevent -l # wait for touch
touch events are reported
```

-   \[ \] touch is accurate

Camera tests
------------

-   \[ \] Camera can be plugged and is detected by Android
-   \[ \] We can take a picture with camera

OTA tests
---------

### Package generation

-   \[ \] It is possible to generate an OTA package in the build See:
    https://source.android.com/devices/tech/ota/tools

### Reboot flow

-   \[ \] `adb reboot bootloader` device waits in fastboot mode and can
    be listed with `fastboot devices`
-   \[ \] `adb reboot recovery` device reboots into recoveryOS, recovery
    menu is visible
-   \[ \] `adb reboot sideload` device reboots into recoveryOS, waiting
    for OTA.zip
-   \[ \] `adb reboot sideload-auto-reboot` device reboots into
    recoveryOS, waiting for OTA.zip

### package installation

-   \[ \] `adb sideload <ota.zip>` applies successfully
