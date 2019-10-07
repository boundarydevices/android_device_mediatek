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

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/mediatek/common-kernel/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Shipping API level to Android P (28)
PRODUCT_SHIPPING_API_LEVEL := 28

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

PRODUCT_PACKAGES += \
    gatekeeper.mtk \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gatekeeper=mtk

# 3D CPU renderer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.allocator@2.0-impl \

# graphics bringup with swiftshader from Q preview
PRODUCT_COPY_FILES += \
    device/mediatek/common/binaries/egl/lib/libEGL_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libEGL_swiftshader.so \
    device/mediatek/common/binaries/egl/lib/libGLESv1_CM_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv1_CM_swiftshader.so \
    device/mediatek/common/binaries/egl/lib/libGLESv2_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv2_swiftshader.so \
    device/mediatek/common/binaries/egl/lib64/libEGL_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libEGL_swiftshader.so \
    device/mediatek/common/binaries/egl/lib64/libGLESv1_CM_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv1_CM_swiftshader.so \
    device/mediatek/common/binaries/egl/lib64/libGLESv2_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv2_swiftshader.so \


# Gralloc
PRODUCT_PACKAGES += \
	gralloc.mtk
PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.gralloc=mtk

# Backlight/brightness
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.mediatek \

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-service.mediatek \
    android.hardware.audio.effect@4.0-impl \

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

# Wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    wpa_supplicant \
    hostapd \
    wificond \
    wifilogd \

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi@1.0 \
    wifi-service \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \

# Usb
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \

# app widget, needed for default launcher3
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \

# RecoveryOS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.mediatek.rc:recovery/root/vendor/etc/init/init.recovery.mediatek.rc

# Add support for common utils: vendor ueventd.rc and (optional) debug tools
$(call inherit-product, device/mediatek/common/utils/utils.mk)
