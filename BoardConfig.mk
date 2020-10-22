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

include device/mediatek/common/soc/mt8183/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := quartz

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    androidboot.serialno=77848183 \
    printk.devkmsg=on \
    init=/init firmware_class.path=/vendor/firmware \
    androidboot.selinux=permissive \
    androidboot.boot_devices=soc/11230000.mmc

# FS configuration
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE    := 16777216
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13108231168
BOARD_DTBOIMG_PARTITION_SIZE       := 1048576
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_BOOTIMAGE_PARTITION_SIZE     := 33554432
BOARD_SUPER_PARTITION_SIZE         := 2415919104
BOARD_DB_DYNAMIC_PARTITIONS_SIZE   := 2415919104
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432

BOARD_SEPOLICY_DIRS += \
    device/mediatek/quartz/sepolicy

MTK_PARTITIONS_YAML := device/mediatek/quartz/partitions.yaml
 
# Please keep this list fixed: add new files in the end of the list
DTB_FILES := \
        $(LOCAL_DTB)/mt8183-pumpkin.dtb

# Please keep this list fixed: add new files in the end of the list
DTBO_FILES := \
        $(LOCAL_DTB)/mt8183-pumpkin-android.dtb \
        $(LOCAL_DTB)/mt8183-pumpkin-urt-umo-9465md-t.dtb


# Additional hardware features
# NOTE: must be called last, as they append Board variables such
# as DEVICE_MANIFEST_FILE
-include vendor/mediatek/mt7668/BoardConfig-mt7668.mk
# Touchscreen
include vendor/ilitek/ili251x/BoardConfig-ili251x.mk
