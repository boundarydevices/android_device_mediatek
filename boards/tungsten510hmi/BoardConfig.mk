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

# enable AVB by default
TARGET_AVB_ENABLE:=true

# override default serial speed
BOARD_KERNEL_SERIAL_SPEED := 115200

include device/mediatek/soc/mt8188/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := tungsten510hmi

# kernel commandline
BOARD_KERNEL_CMDLINE += \
    androidboot.boot_devices=soc/11230000.mmc \
    androidboot.hardware=mt8390 quiet \
    androidboot.serialno=tungsten510hmi

# FS configuration
BOARD_SUPER_PARTITION_SIZE            := 4831838208
BOARD_DTBOIMG_PARTITION_SIZE          := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE        := 50331648
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE  := 16777216
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_DB_DYNAMIC_PARTITIONS_SIZE      := 2411724800

MTK_PARTITIONS_YAML := device/mediatek/boards/tungsten510hmi/partitions.yaml

# Please keep this list fixed: add new files in the end of the list
DTB_FILES := \
    $(MTK_KERNEL_DIST)/mt8370-tungsten-smarc-hmi.dtb

# Please keep this list fixed: add new files in the end of the list
DTBO_FILES := \
    $(MTK_KERNEL_DIST)/mt83x0-tungsten-smarc-android-hmi-dt0214.dtb \
    $(MTK_KERNEL_DIST)/mt83x0-tungsten-smarc-android.dtb

# Bluetooth
include device/mediatek/bluetooth/BoardConfig.mk

# WiFi
include device/mediatek/wifi/BoardConfig.mk
