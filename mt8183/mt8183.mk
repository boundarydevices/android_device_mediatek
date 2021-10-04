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

$(call inherit-product, device/mediatek/common/device-common.mk)

# ARMNN hal (gpu tuning file)
$(call inherit-product, vendor/arm/android-nn-driver/armnn.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8183.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8183.rc \


# fstab
ifeq ($(TARGET_USE_AB_SLOT), true)
ifeq ($(TARGET_AVB_ENABLE), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.avb.ab:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt8183 \
    $(LOCAL_PATH)/fstab.mt8183.avb.ab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.ab:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt8183 \
    $(LOCAL_PATH)/fstab.mt8183.ab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
endif
else
ifeq ($(TARGET_AVB_ENABLE), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.avb:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt8183 \
    $(LOCAL_PATH)/fstab.mt8183.avb:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt8183 \
    $(LOCAL_PATH)/fstab.mt8183:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
endif
endif

# Flashing binaries
ifneq ($(TARGET_USE_PRODUCT_SPECIFIC_LK), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/lk.bin:$(TARGET_OUT)/lk.bin \
    $(LOCAL_PATH)/binaries/images/dl_addr.ini:$(TARGET_OUT)/dl_addr.ini
endif # neq $(TARGET_USE_PRODUCT_SPECIFIC_LK), true)


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

# Media configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_xml/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media_xml/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# Audio policy configuration
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_xml/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Add support of Mali GPU
PRODUCT_SOONG_NAMESPACES += vendor/mediatek/prebuilts/egl/mali/i500

PRODUCT_PACKAGES += \
    libGLES_mali \
    hwcomposer.drm \
    libOpenCL.so libOpenCL.so.1 libOpenCL.so.1.1 libOpenCL.so.1.2 \
    arm.graphics \
    arm.graphics-ndk_platform \
    liblibarm_mali_config_sysprops

# Public Libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.hwcomposer=drm

ifeq ($(TARGET_VKMS_ENABLED), true)
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.hwc.drm.device=/dev/dri/card0
else
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.hwc.drm.device=/dev/dri/card2
endif

# 3D CPU renderer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.graphics.mapper@4.0-impl-arm \
    android.hardware.graphics.allocator@4.0-impl-arm \
    android.hardware.graphics.allocator@4.0-service

PRODUCT_PACKAGES +=  vulkan.mali

VENDOR_UEVENTD_FILES += \
    vendor/mediatek/prebuilts/egl/mali/ueventd.rc

PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3-service-armnn

PRODUCT_PROPERTY_OVERRIDES += \
    Armnn.operandTypeTensorQuant8AsymmPerformance.execTime=2 \
    Armnn.operandTypeTensorQuant8AsymmPerformance.powerUsage=2 \
    Armnn.operandTypeTensorQuant8SymmPerformance.execTime=2 \
    Armnn.operandTypeTensorQuant8SymmPerformance.powerUsage=2 \
    Armnn.operandTypeTensorQuant8SymmPerChannelPerformance.execTime=2 \
    Armnn.operandTypeTensorQuant8SymmPerChannelPerformance.powerUsage=2

PRODUCT_PACKAGES += vpud.mt8183
VENDOR_UEVENTD_FILES += device/mediatek/common/ueventd/ueventd.vpud.rc

# Secure Companion Processor (SCP) firmware
PRODUCT_COPY_FILES += \
    device/mediatek/common/mt8183/binaries/scp/scp.img:$(TARGET_COPY_OUT_VENDOR)/firmware/scp.img

# OP-TEE
OPTEE_PLATFORM := mediatek-mt8183
OPTEE_PLATFORM_FLAVOR := mt8183
OPTEE_CFG_DRAM_SIZE := 0x80000000

# Cadence Neural Networks HAL for VP6 acceleration
# This requires NDA to get access
$(call inherit-product-if-exists, vendor/cadence/prebuilts/i500/vp6.mk)
