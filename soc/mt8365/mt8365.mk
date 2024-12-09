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

$(call inherit-product, device/mediatek/device.mk)

# Specify the model
PRODUCT_PRODUCT_PROPERTIES += \
    ro.soc.model=i350

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8365.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8365.rc

# Fstab
MTK_FSTAB := fstab.mt8365

# Media configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_xml/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media_xml/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# Camera HAL
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/libcamera/camera_hal.yaml:$(TARGET_COPY_OUT_VENDOR)/etc/libcamera/camera_hal.yaml

# Add support of Mali GPU
PRODUCT_SOONG_NAMESPACES += vendor/mediatek/prebuilts/egl/mali/i350

ifeq ($(TARGET_VKMS_ENABLED), true)
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.hwc.drm.device=/dev/dri/card0
else
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.hwc.drm.device=/dev/dri/card2
endif

# Public Libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# MDP support
PRODUCT_PACKAGES += \
    libmdp.mt8365 mdpd

# OP-TEE
OPTEE_PLATFORM := mediatek-mt8175
OPTEE_PLATFORM_FLAVOR := mt8175
OPTEE_CFG_DRAM_SIZE := 0x80000000
