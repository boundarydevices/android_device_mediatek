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

# Audio HAL configuration file
ifneq ($(TARGET_AUDIO_HAL_XML),)
# product specific audio HAL configuration file
PRODUCT_COPY_FILES += \
    $(TARGET_AUDIO_HAL_XML):$(TARGET_COPY_OUT_VENDOR)/etc/audio_hal_configuration.xml
else
# default audio HAL configuration file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_xml/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hal_configuration.xml
endif

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
    $(LOCAL_PATH)/binaries/images/dl_addr.ini:$(TARGET_OUT)/dl_addr.ini

# BL2
ifneq ($(TARGET_USE_PRODUCT_SPECIFIC_BL2), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/bl2.img:$(TARGET_OUT)/bl2.img
endif # neq $(TARGET_USE_PRODUCT_SPECIFIC_BL2), true)

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

ifeq ($(PLATFORM_VERSION), 9)
# Add support of Mali GPU
PRODUCT_PACKAGES += \
    libGLES_mali \
    gralloc.mt6771

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=mt6771 \
    ro.hardware.egl=mali

VENDOR_UEVENTD_FILES += \
    device/mediatek/common/binaries/egl/mali/ueventd.rc
else
# graphics bringup with swiftshader
PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader

# Gralloc
PRODUCT_PACKAGES += \
    gralloc.mtk
endif

PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.2-service-armnn

PRODUCT_PROPERTY_OVERRIDES += \
    ArmNN.quantized8Performance.execTime=2 \
    ArmNN.quantized8Performance.powerUsage=2
