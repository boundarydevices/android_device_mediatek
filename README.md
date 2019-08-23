# mt8167 Pumpkin Board

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

### {boot,system,vendor,cache,userdata,recovery,vbmeta}.img
Now, start the usual Android build setup:

```sh
cd ~/src/june-master
source build/envsetup.sh
lunch mt8167-userdebug
make -j40
```

Note: to only rebuild a particular image, run `make <name>image`.
For example, for `vendor.img`:

```sh
make vendorimage -j40
```

### dtbo.img
To rebuild the device tree overlay (dtbo) image, we can use `mkdtimg`:

```sh
mkdtimg create device/mediatek/mt8167-kernel/dtbo.img device/mediatek/mt8167-kernel/pumpkin8167s_emmc_yocto.dtb  device/mediatek/mt8167-kernel/pumpkin8516_emmc_android.dtb
```

Note that this is *optional*, as some prebuild kernel binaries
are available in: `src/june-master/device/mediatek/mt8167-kernel/`

### kernel
To re-build the kernel, we can do the following:

```sh
cd ~/src/june-master/linux/
# toolchain for building kernel
export PATH="$PATH:~/src/june-master/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin"
# defconfig copy
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-androidkernel- pumpkin_mt8167_defconfig
# build kernel
make DTC_FLAGS="-@" ARCH=arm64 CROSS_COMPILE=aarch64-linux-androidkernel- -j40 && \
    cp arch/arm64/boot/Image ~/src/june/device/mediatek/mt8167-kernel/Image && \
    cp arch/arm64/boot/dts/mediatek/*.dtb ~/src/june-master/device/mediatek/mt8167-kernel/
```

Note that this is *optional*, as some prebuild kernel binaries
are available in: `~/src/june-master/device/mediatek/mt8167-kernel/`

## Flashing
### Install the flashing tool
The flashing tools is delivered as part of the build.
Still this requires to install some dependencies:
```sh
pip2 install --user pyserial
```
### Flashing command
In order to fully flash the device, run the following command:

```sh
cd ~/src/june-master/out/target/product/mt8167
python2 flashimage.py
```

This requires to run the pumpkin in download mode which could be achieved by
holding VOL+ button while reseting or power cycling the board.

## Tips
### stay awake
As soon as the device boots, the screen will go off and it will go into suspend.
When that happens, the UART console is blocked as well.

To avoid that, you can tell the power manager to stay awake:

```sh
svc power stayon true
```

Alternatively, you can hold a wakelock via the commandline:

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
