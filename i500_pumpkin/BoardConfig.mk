#
# Copyright 2019 BayLibre SAS
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

include device/mediatek/common/mt8183/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := i500_pumpkin

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    printk.devkmsg=on \
    init=/init firmware_class.path=/vendor/firmware \
    androidboot.boot_devices=soc/11230000.mmc \
    mem_sleep_default=s2idle

# kernel modules required for ap1302 isp
BOARD_VENDOR_KERNEL_MODULES += \
    device/mediatek/kernel-binaries/$(TARGET_KERNEL_USE)/ap1302.ko

# FS configuration
BOARD_SUPER_PARTITION_SIZE         := 4831838208
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_DTBOIMG_PARTITION_SIZE       := 1048576
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_DB_DYNAMIC_PARTITIONS_SIZE   := 2411724800

BOARD_USES_METADATA_PARTITION := true

BOARD_SEPOLICY_DIRS += \
    device/mediatek/board/i500_pumpkin/sepolicy

ifeq ($(TARGET_AVB_ENABLE), true)
MTK_PARTITIONS_YAML := device/mediatek/board/i500_pumpkin/partitions.avb.yaml
else
MTK_PARTITIONS_YAML := device/mediatek/board/i500_pumpkin/partitions.yaml
endif

# Please keep this list fixed: add new files in the end of the list
DTB_FILES := \
        $(LOCAL_DTB)/mt8183-pumpkin.dtb

# Please keep this list fixed: add new files in the end of the list
DTBO_FILES := \
        $(LOCAL_DTB)/mt8183-pumpkin-android.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-urt-umo-9465md-t.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ar0330-single.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ar0330-dual.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ap1302-ar0330-single.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ap1302-ar0144-single.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ap1302-ar0144-dual.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ap1302-ar0330-single-ar0144-single.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-ap1302-ar0330-single-ar0144-dual.dtb

# Additional hardware features
# NOTE: must be called last, as they append Board variables such
# as DEVICE_MANIFEST_FILE
-include vendor/mediatek/wireless/BoardConfig-mt7668.mk
# Touchscreen
include vendor/ilitek/BoardConfig-ili251x.mk
# UVC Camera
include hardware/mediatek/camera/uvc/BoardConfig.mk
# CSI Camera
include hardware/mediatek/camera/csi/BoardConfig.mk
DEVICE_MANIFEST_FILE += hardware/mediatek/camera/manifest-uvc-csi.xml
