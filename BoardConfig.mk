#
# Copyright 2020 BayLibre SAS
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

# custom mediatek flag
BOARD_VENDOR_MEDIATEK := true

# Primary Arch
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=

# Secondary Arch
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# use 64 bits libraries
TARGET_IS_64_BIT := true

# Enable vndk
BOARD_VNDK_VERSION := current

# Android 12 bringup, should be removed
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# AVB
ifeq ($(TARGET_BUILD_VARIANT), user)
TARGET_AVB_ENABLE:=true
endif

ifeq ($(TARGET_AVB_ENABLE), true)
BOARD_AVB_ENABLE := true
else
BOARD_AVB_ENABLE := false
endif

# Sepolicy
ifneq ($(BOARD_SEPOLICY_DIRS),)
$(error device/mediatek/common/BoardConfigCommon.mk should be included first)
endif
BOARD_SEPOLICY_DIRS := device/mediatek/common/sepolicy

# Kernel
include device/mediatek/common/kernel/BoardConfig.mk

# Filesystems
include device/mediatek/common/fs/BoardConfig.mk

# Recovery
include device/mediatek/common/recovery/BoardConfig.mk

# Audio
include device/mediatek/common/audio/BoardConfig.mk

# USB
include device/mediatek/common/usb/BoardConfig.mk

# Graphics
include device/mediatek/common/graphics/BoardConfig.mk

# Security
include device/mediatek/common/security/BoardConfig.mk

# Media
include device/mediatek/common/media/BoardConfig.mk

# Display
include device/mediatek/common/display/BoardConfig.mk

# Fastboot
include device/mediatek/common/fastboot/BoardConfig.mk

# Boot
include device/mediatek/common/boot/BoardConfig.mk
