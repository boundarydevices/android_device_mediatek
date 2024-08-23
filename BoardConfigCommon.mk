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

# bootimage generation
BOARD_KERNEL_BASE = 0x40000000
BOARD_KERNEL_OFFSET = 0x00200000
BOARD_RAMDISK_OFFSET = 0x15000000
BOARD_TAGS_OFFSET = 0x14000000
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

ifneq ($(BOARD_VENDOR_KERNEL_MODULES),)
$(error device/mediatek/common/BoardConfigCommon.mk should be included first)
endif

BOARD_VENDOR_KERNEL_MODULES := \
    device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mediatek-drm.ko \
    device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/snd-soc-hdmi-codec.ko \
    device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mediatek-drm-hdmi.ko \
    device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/ntc_thermistor.ko

ifneq ($(BOARD_RECOVERY_KERNEL_MODULES),)
$(error device/mediatek/common/BoardConfigCommon.mk should be included first)
endif

BOARD_RECOVERY_KERNEL_MODULES := \
    device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mediatek-drm.ko \
    device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mediatek-drm-hdmi.ko

ifneq ($(MTK_USES_GKI),)

# Built as module when using GKI
BOARD_VENDOR_KERNEL_MODULES += \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/goodix.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/phy-mtk-hdmi-drv.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/phy-mtk-tphy.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/pwm-mtk-disp.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/snd-soc-mt6358.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-kpd.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/tcpci_mt6360.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/v4l2-fwnode.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-seninf.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/phy-generic.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/tusb322i.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtu3.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/xhci-mtk-hcd.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/musb_hdrc.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mediatek.ko \

# Necesasry modules to boot the board to the userland
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6397.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/btmtkuart.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mediatek-cpufreq.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/hwmon.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/ntc_thermistor.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/kfifo_buf.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/nvmem_mtk-efuse.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/regmap-spmi.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6311-regulator.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6315-regulator.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6323-regulator.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6358-regulator.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6380-regulator.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mt6397-regulator.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk_wdt.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/cqhci.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-sd.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-svs.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/matrix-keymap.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-pmic-keys.ko \
device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-pmic-wrap.ko \
# Uart still built-in for debug purposes, but long term it shall be built as modules
#device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/8250_mtk.ko \
#device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/mtk-uart-apdma.ko \

endif

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

ifneq ($(BOARD_SEPOLICY_DIRS),)
$(error device/mediatek/common/BoardConfigCommon.mk should be included first)
endif
BOARD_SEPOLICY_DIRS := \
        device/mediatek/common/sepolicy/30.0/vendor

# USB Hal
BOARD_SEPOLICY_DIRS += \
        hardware/mediatek/usb/1.2/sepolicy

ifeq ($(TARGET_KERNEL_USE), 5.4)
DEVICE_MANIFEST_FILE += device/mediatek/common/manifest_kernel5.xml
endif

BOARD_VENDOR_MEDIATEK := true

# Set location of DTB/DTBO files
LOCAL_DTB := device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/

# Pass unsigned dtbo image (generated by common/build/tasks/dtimages.mk) to Android
# build system for AVB signing
DTBO_UNSIGNED := dtbo-unsigned.img
# $(PRODUCT_OUT) hasn't been defined yet, so use "=" instead of ":="
# so that it is resolved later
BOARD_PREBUILT_DTBOIMAGE = $(PRODUCT_OUT)/$(DTBO_UNSIGNED)

# AVB
ifeq ($(TARGET_BUILD_VARIANT), user)
TARGET_AVB_ENABLE:=true
endif

ifeq ($(TARGET_AVB_ENABLE), true)
BOARD_AVB_ENABLE := true
else
BOARD_AVB_ENABLE := false
endif

BOARD_INCLUDE_RECOVERY_DTBO := true

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
        boot \
        dtbo \
        system \
        vendor

ifeq ($(TARGET_AVB_ENABLE), true)
AB_OTA_PARTITIONS += vbmeta
endif

BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true

# Userdata
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Super partition
TARGET_USE_DYNAMIC_PARTITIONS := true
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_PARTITION_GROUPS := db_dynamic_partitions
BOARD_DB_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor
BOARD_SUPER_PARTITION_METADATA_DEVICE := super
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true

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

# WARNING: do *NOT* edit BOARD_USERDATAIMAGE_PARTITION_SIZE
# the userdata partition will automatically take the remaining eMMC space
# since it's the last partition in the partitioning table, userdata
# partition must align 64KiB to comply with the flasher (LK) specifications
MTK_PRODUCT_OUT := $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)
BOARD_USERDATAIMAGE_PARTITION_SIZE = $(shell \
	mkdir -p $(MTK_PRODUCT_OUT); \
	python3  vendor/mediatek/tools/mbr/gen_partition_xml.py \
	$(MTK_PARTITIONS_YAML) $(MTK_PRODUCT_OUT) \
	--cache $(BOARD_CACHEIMAGE_PARTITION_SIZE) \
	--boot $(BOARD_BOOTIMAGE_PARTITION_SIZE) \
	--recovery $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) \
	--product $(BOARD_PRODUCTIMAGE_PARTITION_SIZE) \
	--oem $(BOARD_OEMIMAGE_PARTITION_SIZE) \
	--dtbo $(BOARD_DTBOIMG_PARTITION_SIZE) \
	--super $(BOARD_SUPER_PARTITION_SIZE); \
	awk '/userdata:/ || /userdata_a:/ {flag=1} flag && /size:/{print $$NF;flag="";exit}' \
	${MTK_PRODUCT_OUT}/partitions.yaml)
