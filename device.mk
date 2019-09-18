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
LOCAL_KERNEL := device/mediatek/mt8183-kernel/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_UBOOT_SPLASHSCREEN ?= device/mediatek/mt8183/binaries/images/splashscreen.raw

# Shipping API level to Android P (28)
PRODUCT_SHIPPING_API_LEVEL := 28

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8183.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8183.rc \
    $(LOCAL_PATH)/init.mt8183.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8183.usb.rc \
    $(LOCAL_PATH)/fstab.mt8183:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183

$(call inherit-product-if-exists, vendor/mediatek/mt8183/device-vendor.mk)

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
    device/mediatek/mt8183/binaries/lib/egl/libEGL_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libEGL_swiftshader.so \
    device/mediatek/mt8183/binaries/lib/egl/libGLESv1_CM_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv1_CM_swiftshader.so \
    device/mediatek/mt8183/binaries/lib/egl/libGLESv2_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv2_swiftshader.so \
    device/mediatek/mt8183/binaries/lib64/egl/libEGL_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libEGL_swiftshader.so \
    device/mediatek/mt8183/binaries/lib64/egl/libGLESv1_CM_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv1_CM_swiftshader.so \
    device/mediatek/mt8183/binaries/lib64/egl/libGLESv2_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv2_swiftshader.so \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=360

# Backlight/brightness
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.mediatek \

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-service.mediatek \
    android.hardware.audio.effect@4.0-impl \

PRODUCT_COPY_FILES += \
    device/mediatek/mt8183/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    device/mediatek/mt8183/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    device/mediatek/mt8183/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    device/mediatek/mt8183/audio/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    device/mediatek/mt8183/audio/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hal_configuration.xml \

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

# Touchscreen
PRODUCT_COPY_FILES += \
    device/mediatek/mt8183/touchscreen/goodix_5688_cfg.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/goodix_5688_cfg.bin \
    device/mediatek/mt8183/touchscreen/init.goodix.rc:$(TARGET_COPY_OUT_VENDOR)//etc/init/init.goodix.rc \

# Usb
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \

# Flashing binaries
PRODUCT_COPY_FILES += \
    device/mediatek/mt8183/binaries/images/lk.bin:$(TARGET_OUT)/lk.bin \
    device/mediatek/mt8183/binaries/images/fip.bin:$(TARGET_OUT)/fip.bin \
    $(PRODUCT_UBOOT_SPLASHSCREEN):$(TARGET_OUT)/splashscreen.raw \
    device/mediatek/mt8183/binaries/images/bl2.img:$(TARGET_OUT)/bl2.img \
    device/mediatek/mt8183/binaries/images/dl_addr.ini:$(TARGET_OUT)/dl_addr.ini \
    device/mediatek/mt8183/binaries/images/u-boot-initial-env:$(TARGET_OUT)/u-boot-initial-env \

# RecoveryOS
PRODUCT_COPY_FILES += \
    device/mediatek/mt8183/init.recovery.mt8183.rc:recovery/root/init.recovery.mt8183.rc

# app widget, needed for default launcher3
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \

# Add support of MT7668 WiFi module
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)

# Add support for common utils: vendor ueventd.rc and (optional) debug tools
$(call inherit-product, device/mediatek/common/utils/utils.mk)
