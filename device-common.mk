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

ifndef TARGET_KERNEL_USE
TARGET_KERNEL_USE=4.19
endif

# Disable kernel config check for now
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/mediatek/common-kernel/$(TARGET_KERNEL_USE)/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mediatek.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.rc \
    $(LOCAL_PATH)/init.mediatek.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.usb.rc \

# Health: Install default binderized implementation to vendor.
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl-batteryless

ifneq ($(TARGET_USE_AB_SLOT), true)
# For non-A/B devices, install default passthrough implementation to recovery.
PRODUCT_PACKAGES += android.hardware.health@2.1-impl-batteryless.recovery
endif

# Backlight/brightness
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.mediatek \

# Security
ifeq ($(OPTEE_ENABLE), true)
$(call inherit-product, $(LOCAL_PATH)/optee/device-optee.mk)
endif

ifeq ($(TEE_KEYMASTER_GATEKEEPER_ENABLE), true)
$(call inherit-product, $(LOCAL_PATH)/optee/kmgk.mk)
else
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service \
    android.hardware.gatekeeper@1.0-service.software
endif

# SurfaceFlinger
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service

# mt8183 and mt8167 both have the same OpenGL ES version (3.2)
# this value should be moved in specific soc folder if it's not aligned in next deliveries
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196610

#enforce permission allowlists for system apps.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=enforce

# Audio:
# NOTE: each product should also add audio.primary.$(TARGET_DEVICE) to its PRODUCT_PACKAGES
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:vendor/etc/audio_effects.xml

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

# Vulkan
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:vendor/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:vendor/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml

# RecoveryOS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.mediatek.rc:recovery/root/vendor/etc/init/init.recovery.mediatek.rc

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    device/mediatek/common/hal/media_xml/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml

# Power HAL
PRODUCT_PACKAGES += android.hardware.power-service.example

# Add support for common utils: vendor ueventd.rc and (optional) debug tools
$(call inherit-product, device/mediatek/common/soc/utils/utils.mk)

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

ifeq ($(TARGET_USE_AB_SLOT), true)
# A/B Support
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    android.hardware.boot@1.1-impl \
    android.hardware.boot@1.1-impl.recovery \
    android.hardware.boot@1.1-service \
    bootctrl.default

PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client \
    SystemUpdaterSample

endif # eq $(TARGET_USE_AB_SLOT), true
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Copy xml file to support backup function
PRODUCT_COPY_FILES += \
frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml

# Copy xml file to support PIN, pattern and password LOck
 PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.secure_lock_screen.xml:system/etc/permissions/android.software.secure_lock_screen.xml

ifeq ($(TARGET_AVB_ENABLE), true)
#copy xml file to tell PackageManager that the system supports Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml
endif # eq $(TARGET_AVB_ENABLE), true

# Supported features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml
