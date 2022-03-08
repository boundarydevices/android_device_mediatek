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

include device/mediatek/common/mt8167/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := i300a_sb30

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    firmware_class.path=/vendor/firmware \
    androidboot.selinux=permissive printk.devkmsg=on \
    init=/init \
    androidboot.boot_devices=soc/11120000.mmc

# FS configuration
BOARD_SUPER_PARTITION_SIZE         := 4831838208
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_DTBOIMG_PARTITION_SIZE       := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_DB_DYNAMIC_PARTITIONS_SIZE   := 2411724800

BOARD_SEPOLICY_DIRS += \
    device/mediatek/board/i300a_sb30/sepolicy

ifeq ($(TARGET_AVB_ENABLE), true)
MTK_PARTITIONS_YAML := device/mediatek/board/i300a_sb30/partitions.avb.yaml
else
MTK_PARTITIONS_YAML := device/mediatek/board/i300a_sb30/partitions.yaml
endif

# Please keep this list fixed: add new files in the end of the list
DTB_FILES := \
        $(LOCAL_DTB)/mt8167-sb30.dtb

# Please keep this list fixed: add new files in the end of the list
DTBO_FILES := \
        $(LOCAL_DTB)/mt8167-sb30-android.dtb 

# Additional hardware features
# NOTE: must be called last, as they append Board variables such
# as DEVICE_MANIFEST_FILE
-include vendor/mediatek/wireless/BoardConfig-mt7668.mk
# UVC Camera
include hardware/mediatek/camera/uvc/BoardConfig.mk
DEVICE_MANIFEST_FILE += hardware/mediatek/camera/manifest-uvc.xml
