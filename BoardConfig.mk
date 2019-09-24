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

# Primary Arch
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a73

# Secondary Arch
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_IS_64_BIT := true
TARGET_USES_64_BIT_BINDER := true

# Enable vndk
BOARD_VNDK_VERSION := current

# bootimage generation
BOARD_KERNEL_BASE = 0x40000000
BOARD_KERNEL_OFFSET = 0x00080000
BOARD_RAMDISK_OFFSET = 0x15000000
BOARD_TAGS_OFFSET = 0x14000000

BOARD_MKBOOTIMG_ARGS := \
  --kernel_offset $(BOARD_KERNEL_OFFSET) \
  --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
  --tags_offset $(BOARD_TAGS_OFFSET) \
  --header_version 1

# kernel commandline
BOARD_KERNEL_CMDLINE := \
    root=/dev/mmcblk0p7 printk.devkmsg=on ro rootwait skip_initramfs \
    init=/init firmware_class.path=/vendor/firmware \
    androidboot.selinux=permissive \

BOARD_VENDOR_KERNEL_MODULES := \
    device/mediatek/mt8183-kernel/goodix.ko \
    device/mediatek/mt8183-kernel/cfg80211.ko \
    device/mediatek/mt8183-kernel/wlan_mt7668_sdio.ko \
    device/mediatek/mt8183-kernel/btmtksdio.ko \

BOARD_RECOVERY_KERNEL_MODULES := \
    device/mediatek/mt8183-kernel/goodix.ko \

BOARD_PREBUILT_DTBOIMAGE := device/mediatek/mt8183-kernel/dtbo.img

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

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

BOARD_SEPOLICY_DIRS += \
        device/mediatek/mt8183/sepolicy/ \
        device/mediatek/common/sepolicy/vendor \

DEVICE_MANIFEST_FILE := device/mediatek/mt8183/manifest.xml

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# audio, use XML policy format
USE_XML_AUDIO_POLICY_CONF := 1

# RecoveryOS
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := device/mediatek/mt8183/fstab.recovery.mt8183
TARGET_RELEASETOOLS_EXTENSIONS := device/mediatek/mt8183

BOARD_VENDOR_MEDIATEK := true
MTK_PARTITIONS_YAML := device/mediatek/mt8183/partitions.yaml

# Additional hardware features
# NOTE: must be called last, as they append Board variables such
# as DEVICE_MANIFEST_FILE
-include vendor/mediatek/mt7668/BoardConfig-mt7668.mk
