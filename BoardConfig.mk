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

# Primary 64 bit Arch
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a

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
$(error device/mediatek/BoardConfigCommon.mk should be included first)
endif
BOARD_SEPOLICY_DIRS := device/mediatek/sepolicy

# Kernel
include device/mediatek/kernel/BoardConfig.mk

# Filesystems
include device/mediatek/fs/BoardConfig.mk

# Recovery
include device/mediatek/recovery/BoardConfig.mk

# Audio
include device/mediatek/audio/BoardConfig.mk

# USB
include device/mediatek/usb/BoardConfig.mk

# Graphics
include device/mediatek/graphics/BoardConfig.mk

# Security
include device/mediatek/security/BoardConfig.mk

# Media
include device/mediatek/media/BoardConfig.mk

# Fastboot
include device/mediatek/fastboot/BoardConfig.mk

# Boot
include device/mediatek/boot/BoardConfig.mk
