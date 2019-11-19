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

$(call inherit-product, device/mediatek/common/soc/device-common.mk)

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_xml/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hal_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8183.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8183.rc \

ifeq ($(TARGET_USE_AB_SLOT), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183_ab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183_noab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
endif # eq $(TARGET_USE_AB_SLOT), true

# Flashing binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/lk.bin:$(TARGET_OUT)/lk.bin \
    $(LOCAL_PATH)/binaries/images/bl2.img:$(TARGET_OUT)/bl2.img \
    $(LOCAL_PATH)/binaries/images/dl_addr.ini:$(TARGET_OUT)/dl_addr.ini \

# U-Boot and env
ifneq ($(TARGET_USE_PRODUCT_SPECIFIC_UBOOT), true)
ifeq ($(TARGET_USE_AB_SLOT), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/fip_ab.bin:$(TARGET_OUT)/fip.bin \
    $(LOCAL_PATH)/binaries/images/u-boot-initial-env_ab:$(TARGET_OUT)/u-boot-initial-env
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/fip_noab.bin:$(TARGET_OUT)/fip.bin \
    $(LOCAL_PATH)/binaries/images/u-boot-initial-env_noab:$(TARGET_OUT)/u-boot-initial-env
endif # eq $(TARGET_USE_AB_SLOT), true
endif # neq $(TARGET_USE_PRODUCT_SPECIFIC_UBOOT), true)

# Optional features
ifeq ($(TARGET_USE_AB_SLOT), true)
# A/B Ota support
PRODUCT_PACKAGES += \
    update_engine \
    update_verifier \
    android.hardware.boot@1.0-service.mediatek \

PRODUCT_PACKAGES_DEBUG += \
    bootctl
endif # eq $(TARGET_USE_AB_SLOT), true

# Backlight/brightness
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.mediatek \
