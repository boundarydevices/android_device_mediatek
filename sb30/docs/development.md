# Developer tips

## Virtual display (vkms)

Android requires a display output (HDMI or DSI panel) in order to boot
to the app launcher. This can be inconvenient for development.

We have a virtual graphics card (based on vkms) which emulates a fake
display. This allows us to boot to the “home screen”.

To configure this, at runtime, do:

    adb root
    adb shell stop
    adb shell stop vendor.hwcomposer-2-1
    adb shell setprop hwc.drm.device /dev/dri/card0
    adb shell start
