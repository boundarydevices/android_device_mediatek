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
# Disable kernel config check for now
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/mediatek/common-kernel/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mediatek.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.rc \
    $(LOCAL_PATH)/init.mediatek.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.usb.rc \

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service.batteryless \

# Security
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Software Gatekeeper HAL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# 3D CPU renderer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.allocator@2.0-impl \

# SurfaceFlinger
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service

# Audio:
# NOTE: each product should also add audio.primary.$(TARGET_DEVICE) to its PRODUCT_PACKAGES
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@4.0-impl \
    android.hardware.audio.effect@4.0-impl

# DRM (Digital Rights Management)
PRODUCT_PACKAGES += \
    android.hardware.drm@1.1-service.clearkey \
    android.hardware.drm@1.1-service.widevine \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.0-impl

# Memtrack
PRODUCT_PACKAGES += memtrack.default \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl

# Usb
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \

# app widget, needed for default launcher3
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \

# RecoveryOS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.mediatek.rc:recovery/root/vendor/etc/init/init.recovery.mediatek.rc

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    device/mediatek/common/hal/media_xml/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml

# Add support for common utils: vendor ueventd.rc and (optional) debug tools
$(call inherit-product, device/mediatek/common/utils/utils.mk)

# ion permissions
VENDOR_UEVENTD_FILES += device/mediatek/common/binaries/egl/ueventd.rc

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)
# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Dynamic partitions
PRODUCT_BUILD_SUPER_PARTITION := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0 \
	android.hardware.fastboot@1.0-impl-mock \
	fastbootd
