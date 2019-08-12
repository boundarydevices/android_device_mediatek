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

### {boot,system,vendor,cache,userdata,recovery}.img
Now, start the usual Android build setup:

```sh
cd ~/src/june-master
source build/envsetup.sh
lunch mt8183-userdebug
make -j40
```

Note: to only rebuild a particular image, run `make <name>image`.
For example, for `vendor.img`:

```sh
make vendorimage -j40
```

### dtbo.img
To build the device tree overlay (dtbo) image, we can use `mkdtimg`:

```sh
mkdtimg create out/target/product/mt8183/dtbo.img \
  ~/src/june-master/device/mediatek/mt8183-kernel/mt8183.dtb
  ~/src/june-master/device/mediatek/mt8183-kernel/mt8183-evb.dtb
```
Note: currently, the SoC device tree (`mt8183.dtb`) is also part of the `dtbo.img`.
This will change when we re-partition.

### kernel
To re-build the kernel, we can do the following:

```sh
cd ~/src/june-master/
source build/envsetup.sh
lunch mt8183-userdebug
cd kernel
DIST_DIR=$ANDROID_BUILD_TOP/device/mediatek/mt8183-kernel/ BUILD_CONFIG=linux/build.config.mt8183 build/build.sh
```

Note that this is *optional*, as some prebuild kernel binaries
are available in: `src/june-master/device/mediatek/mt8183-kernel/`

## Flashing
Flashing is done using `flashimage.py` script. It requires `python2` and the `pyserial` module which can be
installed with:

```sh
pip2 install --user pyserial
```

### Flashing command
In order to fully flash the device, run the following command:

```sh
cd ~/src/june-master/out/target/product/mt8183/
python2 flashimage.py
```
The script waits for the board to go into DA (Download Agent) mode.
To force the board into DA mode, perform the following:
1. Press "volume UP + reset" buttons at the same time.
2. release the reset button.

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
