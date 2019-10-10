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

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    root=/dev/mmcblk0p7 printk.devkmsg=on ro rootwait skip_initramfs \
    init=/init firmware_class.path=/vendor/firmware \
    androidboot.selinux=permissive \

BOARD_VENDOR_KERNEL_MODULES := \
    device/mediatek/common-kernel/goodix.ko \

BOARD_RECOVERY_KERNEL_MODULES := \
    device/mediatek/common-kernel/goodix.ko \

# FS configuration
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2147483648
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE   := 134217728
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE    := 16777216
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3221225472
BOARD_DTBOIMG_PARTITION_SIZE       := 1048576
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_BOOTIMAGE_PARTITION_SIZE     := 33554432
BOARD_PERSISTIMAGE_PARTITION_SIZE  := 33554432

BOARD_SEPOLICY_DIRS += \
    device/mediatek/opal/sepolicy

# RecoveryOS
TARGET_RECOVERY_FSTAB := device/mediatek/opal/fstab.recovery.opal

MTK_PARTITIONS_YAML := device/mediatek/opal/partitions.yaml

# Additional hardware features
# NOTE: must be called last, as they append Board variables such
# as DEVICE_MANIFEST_FILE
-include vendor/mediatek/mt7668/BoardConfig-mt7668.mk
-include vendor/goodix/goodix5688/BoardConfig-goodix5688.mk
