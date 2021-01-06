# Pumpkin i300A

innocomm_sb30 is the device code name for MT8362A on Pumpkin i300A board.

## Fetching the code

Fetch the code using `repo`:

    $ mkdir ~/src/mediatek && cd $_
    $ repo init -u https://gitlab.com/baylibre/aosp/mediatek/manifest.git -b mtk-android-11
    $ repo sync

For more information about `repo`, visit [Android’s official
documentation](https://source.android.com/setup/build/downloading)

Note: if `repo` keeps prompting for your ssh password, add the following
to your `~/.gitconfig`:

    [url "git@gitlab.com:"]
    insteadOf = https://gitlab.com/

## Building

### Setup

Refer to:

  - [Android’s Build
    requirements](https://source.android.com/setup/build/requirements).
  - [Android’s Establishing a Build
    Environment](https://source.android.com/setup/build/initializing)
    guide.

Then, install `pyyaml` for python3:

    $ pip3 install --user pyyaml

`pyyaml` is used by our partitioning tools, which are called at build
time.

### Building Android

    $ cd ~/src/mediatek/
    $ source build/envsetup.sh
    $ lunch innocomm_sb30-userdebug
    $ m -j40

We also support the following build flags to enable optional features:

  - `TARGET_AVB_ENABLE=true` : Enable
    [AVB](https://source.android.com/security/verifiedboot/avb)
  - `TARGET_USE_AB_SLOT=true` : Enable [AB
    partitions](https://source.android.com/devices/tech/ota/ab)

### Rebuilding the Linux kernel

By default, Android’s kernel is build from a prebuilt binary located in:

    ~/src/mediatek/device/mediatek/common-kernel/

To re-build the kernel, refer to
[kernel-guide.md](./docs/kernel-guide.md)

## Flashing

### Prerequisites

Flashing is done via the `flashimage.py` script. It requires `python3`
and some python modules which can be installed with:

    $ pip3 install --user wheel
    $ pip3 install --user pyserial
    $ pip3 install --user oyaml

In order for your host machine to be able to talk to the board through
USB without needing root privileges, you need to create a udev rules
that will grant the *plugdev* group access to your
    device:

    $ echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660", GROUP="plugdev"' | sudo tee -a /etc/udev/rules.d/51-android.rules
    $ sudo udevadm control --reload-rules
    $ sudo udevadm trigger

If your user is not already member of the *plugdev* group:

    $ sudo usermod -a -G plugdev $USER

This last command requires you to log out and log back in to your
account to be in effect.

**Warning:** On Fedora machine, *plugdev* group doesn’t exist, you just
need to
    do:

    $ echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660" | sudo tee -a /etc/udev/rules.d/51-android.rules
    $ sudo udevadm control --reload-rules
    $ sudo udevadm trigger

### Flashing everything

To fully flash the board, run the following:

    $ cd ~/src/mediatek/out/target/product/innocomm_sb30/
    $ ./flashimage.py

Once you see *Waiting for DA mode*:

1)  press the *reset* and *volume up* buttons **simultaneously**
2)  then release only the *reset* button
3)  release the *volume up* button once you see that the image is
    getting flashed.

#### Device-Tree Overlays (DTBO)

The following Device-Tree Overlays are supported:

| dtbo\_index | description               |
| ----------: | :------------------------ |
|           0 | HDMI only                 |
|           1 | Raspberri Pi 7" DSI panel |

To enable one of the above DTBOs, modify the `dtbo_index` at flashing
time by passing the `--update dtbo_index <dtbo_index>` argument:

    $ cd ~/src/mediatek/out/target/product/innocomm_sb30/
    $ ./flashimage.py --update dtbo_index <dtbo_index>

### Flashing only one partition

To flash just one partition, you can run the following command:

    $ cd ~/src/mediatek/out/target/product/innocomm_sb30/
    $ adb reboot bootloader
    $ fastboot flash [PARTITION] [FILE]
    $ fastboot continue

`[PARTITION]` should be replaced with one of the following:

  - *bootloaders*: for flashing the bootloaders (such as u-boot)
  - *boot*: for flashing the Linux Kernel (`boot.img`).
  - *imageXXX*: for flashing an android image named `imageXXX.img`

For example, the commands to flash the bootloaders are:

    $ cd ~/src/mediatek/out/target/product/innocomm_sb30/
    $ adb reboot bootloader
    $ fastboot flash bootloaders fip.bin
    $ fastboot continue

The commands to flash the kernel are:

    $ cd ~/src/mediatek/out/target/product/innocomm_sb30/
    $ adb reboot fastboot
    $ fastboot flash boot boot.img
    $ fastboot flash dtbo dtbo.img
    $ fastboot flash vendor vendor.img
    $ fastboot continue

### Flashing another serial number

All the boards have the same serial number, so to get a custom serial
number you need to flash the board:

    $ ./flashimage.py --update serial# <unique_serial_number>

When reflashing again after setting your custom serial number you have
to flash the board by skipping the env

    $ ./flashimage.py --skip-env

If you don’t, it will erase the existing one and set the default serial
number. Other option: you can flash with fastboot (by doing `adb reboot
bootloader`)

## More documentation

The `docs` folder of this project contains more documentation, such as:

  - [Frequently Asked Questions](./docs/faq.md)
  - [Development tips & tricks](./docs/development.md)
  - [Android kernel developer guide](./docs/kernel-guide.md)
  - [U-Boot developer guide](./docs/uboot-dev.md)
  - [MT7668 WiFi/Bluetooth MAC provisioning](./docs/mt7668-efuse.md)
  - [Kernel source code structure](./docs/kernel-src-org.md)
