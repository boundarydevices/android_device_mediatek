#
# Copyright 2021 BayLibre SAS
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
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# All OP-TEE vars MUST be set before including common/mt*
OPTEE_ENABLE := true
TEE_KEYMASTER_GATEKEEPER_ENABLE := true

$(call inherit-product, device/mediatek/common/mt8365/mt8365.mk)

include device/mediatek/common/common-build-flags.mk

TARGET_USE_PRODUCT_SPECIFIC_BL2 := true
TARGET_USE_PRODUCT_SPECIFIC_LK := true
TARGET_USE_PRODUCT_SPECIFIC_UBOOT := true
PRODUCT_COPY_FILES += \
    device/mediatek/board/i350_sb35/binaries/images/lk-$(TARGET_MODE_BL).bin:lk.bin \
    device/mediatek/common/mt8365/binaries/images/dl_addr.ini:dl_addr.ini

ifeq ($(TARGET_USE_AB_SLOT), true)
PRODUCT_COPY_FILES += \
    device/mediatek/board/i350_sb35//binaries/images/fip_$(TARGET_MODE_BL)_ab.bin:$(TARGET_OUT)/fip.bin \
    device/mediatek/board/i350_sb35//binaries/images/bl2-$(TARGET_MODE_BL).img:$(TARGET_OUT)/bl2.img \
    device/mediatek/board/i350_sb35//binaries/images/u-boot-initial-$(TARGET_MODE_BL)-env_ab:$(TARGET_OUT)/u-boot-initial-env
else
PRODUCT_COPY_FILES += \
    device/mediatek/board/i350_sb35/binaries/images/fip_$(TARGET_MODE_BL)_noab.bin:$(TARGET_OUT)/fip.bin \
    device/mediatek/board/i350_sb35/binaries/images/bl2-$(TARGET_MODE_BL).img:$(TARGET_OUT)/bl2.img \
    device/mediatek/board/i350_sb35/binaries/images/u-boot-initial-$(TARGET_MODE_BL)-env_noab:$(TARGET_OUT)/u-boot-initial-env
endif # eq $(TARGET_USE_AB_SLOT), true


PRODUCT_NAME := i350_sb35
PRODUCT_DEVICE := i350_sb35
PRODUCT_BRAND := Android
PRODUCT_MODEL := i350_sb35
PRODUCT_MANUFACTURER := mediatek

$(call inherit-product, device/mediatek/board/i350_sb35/device.mk)
