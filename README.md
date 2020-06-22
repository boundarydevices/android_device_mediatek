Pumpkin i300A {#board_name}
=============

onyx is the device code name for MT8362A on Pumpkin i300A board.

Fetching the code
-----------------

Fetch the code using `repo`:

    $ mkdir ~/src/mediatek && cd $_
    $ repo init -u https://gitlab.com/baylibre/aosp/mediatek/manifest.git -b mtk-android-10
    $ repo sync

For more information about `repo`, visit [Android's official
documentation](https://source.android.com/setup/build/downloading)

Note: if `repo` keeps prompting for your ssh password, add the following
to your `~/.gitconfig`:

    [url "git@gitlab.com:"]
    insteadOf = https://gitlab.com/

Building
--------

The preferred build environment is identical to Android's official
recommendations. Refer to [Android's Establishing a Build
Environment](https://source.android.com/setup/build/initializing) guide.

Moreover, ensure that your system has `python 2.7` installed as
documented in [Android's Build
requirements](https://source.android.com/setup/build/requirements).

For more build system related topics, see
[build\_system.md](./docs/build_system.md)

### Additional dependencies

The partitioning tools, which are needed during the Android build depend
on `pyyaml`.

`pyyaml` can be installed with:

    $ pip3 install --user pyyaml

### Building everything

    $ cd ~/src/mediatek/
    $ source build/envsetup.sh
    $ lunch aosp_onyx-userdebug
    $ make -j40

### Building a specific image

To rebuild a specific image, run `make <name>image`.

Some examples:

    $ make vendorimage
    $ make bootimage

### Building the Linux kernel

By default, Android's `boot.img` is build from a binary kernel Image
located in:

    ~/src/mediatek/device/mediatek/common-kernel/

To re-build the kernel, refer to
[kernel-guide.md](./docs/kernel-guide.md)

Flashing
--------

### Prerequisites

Flashing is done via the `flashimage.py` script. It requires `python3`
and some python modules which can be installed with:

    $ pip3 install --user wheel
    $ pip3 install --user pyserial
    $ pip3 install --user oyaml

### Flashing everything

To fully flash the board, run the following:

    $ cd ~/src/mediatek/out/target/product/onyx/
    $ ./flashimage.py --update dtb_index 2 --update dtbo_index 3 --env-size 262144

Once you see *Waiting for DA mode*:

1)  press the *reset* and *volume up* buttons **simultaneously**
2)  then release only the *reset* button
3)  release the *volume up* button once you see that the image is
    getting flashed.

### Flashing only one partition

To flash just one partition, you can run the following command:

    $ cd ~/src/mediatek/out/target/product/onyx/
    $ adb reboot bootloader
    $ fastboot flash [PARTITION] [FILE]
    $ fastboot continue

`[PARTITION]` should be replaced with one of the following:

-   *bootloaders*: for flashing the bootloaders (such as u-boot)
-   *boot*: for flashing the Linux Kernel (`boot.img`).
-   *imageXXX*: for flashing an android image named `imageXXX.img`

For example, the commands to flash the bootloaders are:

    $ cd ~/src/mediatek/out/target/product/onyx/
    $ adb reboot bootloader
    $ fastboot flash bootloaders fip.bin
    $ fastboot continue

The commands to flash the kernel are:

    $ cd ~/src/mediatek/out/target/product/onyx/
    $ adb reboot bootloader
    $ fastboot flash boot boot.img
    $ fastboot flash dtbo dtbo.img
    $ fastboot flash vendor vendor.img
    $ fastboot continue

More documentation
------------------

The `docs` folder of this project contains more documentation, such as:

-   [kernel-guide.md](./docs/kernel-guide.md)
-   [uboot-dev.md](./docs/uboot-dev.md)
-   [mt7668-efuse.md](./docs/mt7668-efuse.md)
-   [kernel-src-org.md](./docs/kernel-src-org.md)
