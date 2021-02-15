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

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8183.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8183.rc \


# Ramdisk fstab
ifeq ($(TARGET_USE_AB_SLOT), true)
ifeq ($(TARGET_AVB_ENABLE), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.avb.ab:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt8183
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.ab:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt8183
endif
else
ifeq ($(TARGET_AVB_ENABLE), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.avb:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt8183
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt8183
endif
endif

# Vendor fstab
ifeq ($(TARGET_USE_AB_SLOT), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183.ab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8183:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183
endif

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

# Audio policy configuration
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_xml/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Add support of Mali GPU
PRODUCT_PACKAGES += \
    libGLES_mali \
    gralloc.mt6771 \
    hwcomposer.drm_mediatek

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=mt6771 \
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.hwcomposer=drm_mediatek \
    hwc.drm.device=/dev/dri/card1

# Vulkan
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:vendor/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:vendor/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml

PRODUCT_PACKAGES +=  vulkan.mali.so

VENDOR_UEVENTD_FILES += \
    device/mediatek/common/binaries/egl/mali/ueventd.rc

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

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service-mtk \
    camera.libcamera \
    cam \
    CameraDemo \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.camera=libcamera

PRODUCT_COPY_FILES += \
    device/mediatek/common/hal/camera/csi/init.csi.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.csi.rc \

VENDOR_UEVENTD_FILES += device/mediatek/common/hal/camera/csi/ueventd.csi.rc

# Secure Companion Processor (SCP) firmware
PRODUCT_COPY_FILES += \
    device/mediatek/common/soc/mt8183/binaries/scp/scp.img:$(TARGET_COPY_OUT_VENDOR)/firmware/scp.img

# OP-TEE
OPTEE_PLATFORM := mediatek-mt8183
OPTEE_PLATFORM_FLAVOR := mt8183
OPTEE_CFG_DRAM_SIZE := 0x80000000
