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

# Enable vndk
BOARD_VNDK_VERSION := current

# bootimage generation
BOARD_KERNEL_BASE = 0x40000000
BOARD_KERNEL_OFFSET = 0x00080000
BOARD_RAMDISK_OFFSET = 0x15000000
BOARD_TAGS_OFFSET = 0x14000000

BOARD_MKBOOTIMG_ARGS := \
  --base $(BOARD_KERNEL_BASE) \
  --kernel_offset $(BOARD_KERNEL_OFFSET) \
  --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
  --tags_offset $(BOARD_TAGS_OFFSET) \
  --header_version 1

BOARD_VENDOR_KERNEL_MODULES += \
    device/mediatek/common-kernel/mediatek-drm.ko \
    device/mediatek/common-kernel/mediatek-drm-hdmi.ko

# prebuild dtbo file
BOARD_PREBUILT_DTBOIMAGE := device/mediatek/common-kernel/dtbo.img

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

BOARD_SEPOLICY_DIRS += \
        device/mediatek/common/sepolicy/vendor

DEVICE_MANIFEST_FILE := device/mediatek/common/soc/manifest.xml

BOARD_VENDOR_MEDIATEK := true
