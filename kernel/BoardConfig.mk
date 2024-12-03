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

# bootimage generation
BOARD_KERNEL_BASE = 0x40000000
BOARD_KERNEL_OFFSET = 0x00200000
BOARD_RAMDISK_OFFSET = 0x15000000
BOARD_TAGS_OFFSET = 0x14000000
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

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

ifneq ($(MTK_USES_GKI),)

# Built as module when using GKI
BOARD_VENDOR_KERNEL_MODULES += \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/goodix.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/phy-mtk-hdmi-drv.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/phy-mtk-tphy.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/pwm-mtk-disp.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/snd-soc-mt6358.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk-kpd.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/tcpci_mt6360.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/v4l2-fwnode.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk-seninf.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/phy-generic.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/tusb322i.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtu3.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/xhci-mtk-hcd.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/musb_hdrc.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mediatek.ko \

# Necessary modules to boot the board to the userland
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6397.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/btmtkuart.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mediatek-cpufreq.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/hwmon.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/ntc_thermistor.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/kfifo_buf.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/nvmem_mtk-efuse.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/regmap-spmi.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6311-regulator.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6315-regulator.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6323-regulator.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6358-regulator.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6380-regulator.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mt6397-regulator.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk_wdt.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/cqhci.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk-sd.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk-svs.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/matrix-keymap.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk-pmic-keys.ko \
vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk-pmic-wrap.ko \
# Uart still built-in for debug purposes, but long term it shall be built as modules
#vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/8250_mtk.ko \
#vendor/mediatek/prebuilts/kernely/$(TARGET_KERNEL_USE)/mtk-uart-apdma.ko \

endif
