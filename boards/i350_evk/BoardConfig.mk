#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include device/mediatek/soc/mt8365/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := i350_evk
TARGET_SCREEN_DENSITY := 360

BOARD_SEPOLICY_DIRS += \
    device/mediatek/boards/sepolicy \
    device/mediatek/boards/i350_evk/sepolicy

# kernel commandline
BOARD_KERNEL_CMDLINE += \
    androidboot.boot_devices=soc/11230000.mmc \
    androidboot.hardware=mt8365 \
    androidboot.serialno=i350evk


# kernel modules required for ap1302 isp
BOARD_VENDOR_KERNEL_MODULES += \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/ap1302.ko

# FS configuration
BOARD_SUPER_PARTITION_SIZE            := 4831838208
BOARD_DTBOIMG_PARTITION_SIZE          := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE        := 50331648
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE  := 16777216
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_DB_DYNAMIC_PARTITIONS_SIZE      := 2411724800

MTK_PARTITIONS_YAML := device/mediatek/boards/i350_evk/partitions.yaml

# Please keep this list fixed: add new files in the end of the list
DTB_FILES := \
        $(LOCAL_DTB)/mt8365-evk.dtb

# Please keep this list fixed: add new files in the end of the list
DTBO_FILES := \
        $(LOCAL_DTB)/mt8365-evk-android.dtb \
        $(LOCAL_DTB)/mt8365-evk-android-dsi.dtb \
        $(LOCAL_DTB)/mt8365-evk-android-ap1302-ar0430-single-csi0.dtb \
        $(LOCAL_DTB)/mt8365-evk-android-ap1302-ar0430-single-csi1.dtb \
        $(LOCAL_DTB)/mt8365-evk-android-ap1302-ar0430-dual.dtb

include vendor/mediatek/wireless/BoardConfig-mt7663.mk
