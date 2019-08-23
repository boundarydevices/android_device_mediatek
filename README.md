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
mkdtimg create device/mediatek/mt8167-kernel/dtbo.img \
  device/mediatek/mt8167-kernel/mt8167.dtb \
  device/mediatek/mt8167-kernel/mt8167-pumpkin.dtb
```

Notes:
 - Currently, the SoC device tree (`mt8167.dtb`) is also part of the `dtbo.img`.
   This will change when we re-partition.
 - This step part of the kernel build scripts so does not need to be done manually

### kernel
To re-build the kernel, we can do the following:

```sh
cd ~/src/june-master/
source build/envsetup.sh
lunch mt8167-userdebug
cd kernel
DIST_DIR=$ANDROID_BUILD_TOP/device/mediatek/mt8167-kernel/ BUILD_CONFIG=linux/build.config.mt8167 build/build.sh
```

Note that this is *optional*, as some prebuild kernel binaries
are available in: `~/src/june-master/device/mediatek/mt8167-kernel/`

## Flashing
Flashing is done using `flashimage.py` script. It requires `python2` and the `pyserial` module which can be
installed with:

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
