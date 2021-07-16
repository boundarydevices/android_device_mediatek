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

include device/mediatek/common/soc/mt8167/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := innocomm_sb30

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    firmware_class.path=/vendor/firmware \
    androidboot.selinux=permissive printk.devkmsg=on \
    init=/init \
    androidboot.boot_devices=soc/11120000.mmc

# FS configuration
ifeq ($(TARGET_USE_AB_SLOT), true)
BOARD_SUPER_PARTITION_SIZE         := 4831838208
else
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE    := 16777216
BOARD_SUPER_PARTITION_SIZE         := 2415919104
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
endif
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_DTBOIMG_PARTITION_SIZE       := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_DB_DYNAMIC_PARTITIONS_SIZE   := 2411724800

BOARD_SEPOLICY_DIRS += \
    device/mediatek/board/sb30/sepolicy

ifeq ($(TARGET_USE_AB_SLOT), true)
ifeq ($(TARGET_AVB_ENABLE), true)
MTK_PARTITIONS_YAML := device/mediatek/board/sb30/partitions.avb_ab.yaml
else
MTK_PARTITIONS_YAML := device/mediatek/board/sb30/partitions_ab.yaml
endif
else # TARGET_USE_AB_SLOT == false
ifeq ($(TARGET_AVB_ENABLE), true)
MTK_PARTITIONS_YAML := device/mediatek/board/sb30/partitions.avb.yaml
else
MTK_PARTITIONS_YAML := device/mediatek/board/sb30/partitions.yaml
endif
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
-include vendor/mediatek/mt7668/BoardConfig-mt7668.mk
# UVC Camera
include device/mediatek/common/hal/camera/uvc/BoardConfig.mk
DEVICE_MANIFEST_FILE += device/mediatek/common/hal/camera/manifest-uvc.xml
