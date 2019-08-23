#!/usr/bin/python
import os

procedures = {
    # product   : fastboot args
    'DEFAULT'   : [['daWait'],
                    ['fbWait'],
                    ['fastboot', 'erase', 'mmc0'],
                    ['fastboot', 'flash', 'mmc0', 'MBR_EMMC'],
                    ['fastboot', 'flash', 'mmc0boot0', 'bl2.img'],
                    ['fastboot', 'flash', 'bootloaders', 'fip.bin'],
                    ['fastboot', 'flash', 'dtbo', 'dtbo.img'],
                    ['fastboot', 'flash', 'boot', 'boot.img'],
                    ['fastboot', 'flash', 'vendor', 'vendor.img'],
                    ['fastboot', 'flash', 'userdata', 'userdata.img'],
                    ['fastboot', 'flash', 'cache', 'cache.img'],
                    ['fastboot', 'flash', 'recovery', 'recovery.img'],
                    ['fastboot', 'flash', 'system', 'system.img'] ]
}

userprocedures = {
    # product   : fastboot args
    'DEFAULT'   : [['daWait'],
                    ['fbWait'],
                    ['fastboot', 'erase', 'ROOTFS1'],
                    ['fastboot', 'flash', 'ROOTFS1', 'rootfs.ext4'] ]
}

bootprocedures = {
    # product   : fastboot args
    'DEFAULT'   : [['daWait'],
                    ['fbWait'],
                    ['fastboot', 'erase', 'mmc0'],
                    ['fastboot', 'flash', 'mmc0', 'MBR_EMMC'],
                    ['fastboot', 'flash', 'mmc0boot0', 'bl2.img'],
                    ['fastboot', 'flash', 'bootloaders', 'fip.bin'],
                    ['fastboot', 'flash', 'dtbo', 'dtbo.img'],
                    ['fastboot', 'flash', 'boot', 'boot.img'],
                    ['fastboot', 'flash', 'vendor', 'vendor.img'],
                    ['fastboot', 'flash', 'userdata', 'userdata.img'],
                    ['fastboot', 'flash', 'cache', 'cache.img'],
                    ['fastboot', 'flash', 'system', 'system.img'] ]
}

testprocedures = {
    # product   : fastboot args
    'DEFAULT'   : [['daWait'],
                    ['fbWait'],
                    ['fastboot', 'erase', 'UBOOT'],
                    ['fastboot', 'erase', 'MISC'],
                    ['fastboot', 'erase', 'TEE1'],
                    ['fastboot', 'erase', 'BOOTIMG1'],
                    ['fastboot', 'erase', 'ROOTFS1'],
                    ['fastboot', 'flash', 'bootloaders', 'fip.bin'],
                    ['fastboot', 'flash', 'kernel', 'fitImage'],
                    ['fastboot', 'flash', 'rootfs', 'rootfs.ext4'] ]
}

# return procedure list
def getFlashProc(product):
    try:
        ret = procedures[product.upper()]
        return ret
    except Exception, e:
        return None


def getFlashUserProc(product):
    try:
        ret = userprocedures[product.upper()]
        return ret
    except Exception, e:
        return None

def getFlashBootProc(product):
    try:
        ret = bootprocedures[product.upper()]
        return ret
    except Exception, e:
        return None

def getFlashTestProc(product):
    try:
        ret = testprocedures[product.upper()]
        return ret
    except Exception, e:
        return None
