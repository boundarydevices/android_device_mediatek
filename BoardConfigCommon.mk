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

TARGET_IS_64_BIT := true

# Enable vndk
BOARD_VNDK_VERSION := current

# Android 12 bringup, should be removed
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

ifneq ($(BOARD_SEPOLICY_DIRS),)
$(error device/mediatek/common/BoardConfigCommon.mk should be included first)
endif
BOARD_SEPOLICY_DIRS := \
        device/mediatek/common/sepolicy/30.0/vendor

# USB Hal
BOARD_SEPOLICY_DIRS += \
        hardware/mediatek/usb/1.2/sepolicy

BOARD_VENDOR_MEDIATEK := true

# AVB
ifeq ($(TARGET_BUILD_VARIANT), user)
TARGET_AVB_ENABLE:=true
endif

ifeq ($(TARGET_AVB_ENABLE), true)
BOARD_AVB_ENABLE := true
else
BOARD_AVB_ENABLE := false
endif

BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
ifeq ($(TARGET_AVB_ENABLE), true)
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 2
endif

# Audio HAL
BOARD_USES_TINYHAL_AUDIO := true
TINYALSA_NO_ADD_NEW_CTRLS := true
TINYALSA_NO_CTL_GET_ID := true

# Kernel
include device/mediatek/common/kernel/BoardConfig.mk

# Filesystems
include device/mediatek/common/fs/BoardConfig.mk
