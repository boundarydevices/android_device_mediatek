# mt8183 EValuation Board (EVB)

## Get the code

First, fetch the code with `repo`:

```sh
mkdir ~/src/june-master/ && cd $_
repo init -u https://gitlab.com/baylibre/june/android/manifest.git -b june-master
repo sync
```

For more instructions about `repo`, please visit Android's official documentation:
https://source.android.com/setup/build/downloading


## Building

For more build system related topics, see [build_system.md](./docs/build_system.md)

### {boot,system,vendor,cache}.img
Now, start the usual Android build setup:

```sh
cd ~/src/june-master
source build/envsetup.sh
lunch mt8183-userdebug
make bootimage systemimage vendorimage cacheimage -j40
```

### dtbo.img
To build the device tree overlay (dtbo) image, we can use `mkdtimg`:

```sh
mkdtimg create out/target/product/mt8183/dtbo.img ~/src/june-master/device/mediatek/mt8183-kernel/mt8183-evb.dtb
```

### kernel
To re-build the kernel, we can do the following:

```sh
cd ~/src/june-master/linux/
# toolchain for building kernel
export PATH="$PATH:~/src/june-master/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin"
# defconfig copy
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-androidkernel- mt8183_android_defconfig
# build kernel
make DTC_FLAGS="-@" ARCH=arm64 CROSS_COMPILE=aarch64-linux-androidkernel- -j40 && \
    cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/mediatek/mt8183.dtb > myImage.gz && \
    cp myImage.gz ~/src/june/device/mediatek/mt8183-kernel/kernel && \
    cp arch/arm64/boot/dts/mediatek/mt8183-evb.dtb ~/src/aosp/june/mediatek/mt8183-kernel/mt8183-evb.dtb
```

Note that this is *optional*, as some prebuild kernel binaries
are available in: `src/june-master/device/mediatek/mt8183-kernel/`

## Flashing
### Install SPFlashtool
Flashing is done using SPFlashtool.
Download SPFlashtool here:
https://spflashtools.com/linux/sp-flash-tool-v5-1916-for-linux

Then install it as following:

```sh
cd ~/Downloads/
unzip SP_Flash_Tool_v5.1916_Linux.zip
cd SP_Flash_Tool_v5.1916_Linux
chmod +x flash_tool
chmod +x flash_tool.sh
```

More information on the official website:
https://spflashtools.com/

An useful XDA link about udev rules/conflicts with modemmanager on Ubuntu:
https://forum.xda-developers.com/general/rooting-roms/tutorial-how-to-setup-spflashtoollinux-t3160802

### Flashing command
In order to fully flash the device, run the following command:

```sh
./flash_tool -s ~/src/june-master/out/target/product/mt8183/MT8183_full_scatter.txt -c format-download -r
```

## Tips
### wakelock
As soon as the device boots, the screen will go off and it will go into suspend.
When that happens, the UART console is blocked as well.
To avoid that, you can hold a wakelock via the commandline.

```sh
echo lock_me > /sys/power/wake_lock
echo lock_me > /sys/power/wake_unlock
```

### fake touch events
As the touch panel is not functional yet, it is quite hard to interact with the device.
Fortunately, android has the the `input` command we can use to simulate inputs:

```sh
input keyevent 3 # home button
input keyevent 26 # power button
input keyevent 82 # unlock lock screen
```
For more input codes, see:
https://developer.android.com/reference/android/view/KeyEvent#KEYCODE_BACK
