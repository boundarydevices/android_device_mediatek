#
# Copyright 2024 BayLibre SAS
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

# sepolicy
BOARD_SEPOLICY_DIRS += device/mediatek/kernel/sepolicy

# No GKI support
BOARD_USES_GENERIC_KERNEL_IMAGE := false

# bootimage generation
BOARD_KERNEL_BASE = 0x40000000
BOARD_KERNEL_OFFSET = 0x00200000
BOARD_RAMDISK_OFFSET = 0x15000000
BOARD_TAGS_OFFSET = 0x14000000
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# commandline
BOARD_KERNEL_CMDLINE += \
    firmware_class.path=/vendor/firmware \
    printk.devkmsg=on \
    init=/init

# mkbootimg arguments
BOARD_MKBOOTIMG_ARGS := \
  --kernel_offset $(BOARD_KERNEL_OFFSET) \
  --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
  --tags_offset $(BOARD_TAGS_OFFSET) \
  --header_version 2

# DTB
LOCAL_DTB := vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)

# DTBO
DTBO_UNSIGNED := dtbo-unsigned.img
BOARD_PREBUILT_DTBOIMAGE = $(PRODUCT_OUT)/$(DTBO_UNSIGNED)

BOARD_INCLUDE_RECOVERY_DTBO := true

# kernel modules
ifneq ($(BOARD_VENDOR_KERNEL_MODULES),)
$(error device/mediatek/kernel/BoardConfig.mk should be included first)
endif

BOARD_VENDOR_KERNEL_MODULES := \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mediatek-drm.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/snd-soc-hdmi-codec.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mediatek-drm-hdmi.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/ntc_thermistor.ko

ifneq ($(BOARD_RECOVERY_KERNEL_MODULES),)
$(error device/mediatek/kernel/BoardConfig.mk should be included first)
endif

BOARD_RECOVERY_KERNEL_MODULES := \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mediatek-drm.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mediatek-drm-hdmi.ko
