Bootloaders development guide
=============================

This document details how to rebuild the `bl2.img` bootloader for
pumpkin i300a.\
BL2 is based on ARM Trusted Firmware (ATF).

For U-Boot, please refer to the U-Boot guide:
[uboot-dev.md](./docs/uboot-dev.md)

Fetch the code
--------------

Arm Trusted Firmware:

    $ git clone git@gitlab.com:baylibre/rich-iot/arm-trusted-firmware-private.git

Building
--------

1.  Download and extract **aarch64-none-linux-gnu** toolchain:
    [toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads)

2.  Prepare build environment:

Add the toolchain to `PATH`:

    $ export PATH="~/Documents/Baylibre/toolchain/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin:$PATH"

Set cross compiler:

    $ export CROSS_COMPILE=aarch64-none-linux-gnu-

Compile and saved `mkimage` somewhere in your `PATH` env:

    $ git clone git@gitlab.com:baylibre/rich-iot/u-boot.git -b mtk-v2020.10 && cd $_
    $ make defconfig
    $ make tools-only
    $ cp tools/mkimage ~/.local/bin/

**WARNING**: Please make sure you compile `mkimage` from `mtk-v2020.10`
branch !!!!\
If you use a different version (for example, `mtk-v2019.10`), the
generated `bl2.img` cannot be booted by Pumpkin i300a.

3.  Go to `arm-trusted-firmware-private` folder and execute the
    following script:

         #!/bin/bash

         set -e

         MTK_PLAT="mt8516"
         MTK_CFLAGS="-Wno-error=missing-braces \
                     -Wno-error=unused-function \
                     -Wno-error=unused-variable \
                     -Wno-error=maybe-uninitialized \
                     -Wno-error=unused-const-variable \
                     -Wno-error=unused-value \
                     -Wno-error=enum-compare \
                     -Wno-error=int-to-pointer-cast \
                     -Wno-error=return-type \
                     -Wno-error=pointer-sign \
                     -Wno-error=parentheses \
                     -Wno-error=comment \
                     -Wno-error=unused-but-set-variable \
                     -Wno-error=implicit-function-declaration \
                     -Wno-error=int-conversion \
                     -Wno-error=discarded-qualifiers \
                     -DBOARD_pumpkin"

         make CFLAGS="${MTK_CFLAGS}" PLAT="${MTK_PLAT}" bl2

         cd build/mt8516/release
         cp bl2.bin bl2.img.tmp
         truncate -s%4 bl2.img.tmp

         # mkimage built from git@gitlab.com:baylibre/rich-iot/u-boot.git, branch mtk-v2020.10
         mkimage -T mtk_image -a 0x201000 -e 0x201000 -n "media=emmc;aarch64=1" \
                 -d bl2.img.tmp bl2.img

         rm bl2.img.tmp

Flashing
--------

1)  Download `fbtool.py` from
    [mtk-flash-tools](https://gitlab.com/baylibre/aosp/mediatek/common/tools/mtk-flash-tools)

2)  Download the following files from
    [soc](https://gitlab.com/baylibre/aosp/mediatek/common/soc):\
    `mt8167/binaries/images/dl_addr.ini`\
    `mt8167/binaries/images/lk.bin`

3)  Run `fbtool`:

         $ ./fbtool.py
         INFO: pySerial version: (3.4)
         INFO: Use config file: dl_addr.ini
         INFO: Waiting to connect platform...

4)  press the *reset* and *volume up* buttons **simultaneously**

5)  then release only the *reset* button

6)  release the *volume up* button once you see that `fbtool.py`
    returned successfully:

         $ ./fbtool.py
         INFO: pySerial version: (3.4)
         INFO: Use config file: dl_addr.ini
         INFO: Waiting to connect platform...
         INFO: Got /dev/ttyACM0
         INFO: Connect brom
         INFO: Loading file: lk.bin
         INFO: Send lk.bin
         INFO: Jump da

7)  Flash `bl2.img`:

         $ fastboot flash mmc0boot0 build/mt8516/release/bl2.img
