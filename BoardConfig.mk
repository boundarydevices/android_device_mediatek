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

# Use the non-open-source parts, if they're present
-include vendor/mediatek/mt8167/BoardConfigVendor.mk

# Primary Arch
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

# Secondary Arch
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_IS_64_BIT := true
TARGET_USES_64_BIT_BINDER := true

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    firmware_class.path=/vendor/firmware \
    androidboot.selinux=permissive printk.devkmsg=on \
    ro rootwait skip_initramfs init=/init \

# FS configuration
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2147483648
TARGET_USERIMAGES_USE_EXT4         := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1073741824
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE   := 134217728
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE    := 16777216
BOARD_BOOTIMAGE_PARTITION_SIZE     := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_DTBOIMG_PARTITION_SIZE       := 4194304

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

BOARD_SEPOLICY_DIRS += \
        device/mediatek/mt8167/sepolicy

DEVICE_MANIFEST_FILE := device/mediatek/mt8167/manifest.xml

# enable AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA512_RSA4096
