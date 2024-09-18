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

# Specify the manufacturer
PRODUCT_PRODUCT_PROPERTIES += \
    ro.soc.manufacturer=mediatek

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mediatek.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.rc \
    $(LOCAL_PATH)/init.lights.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.lights.rc \

# persist.img
PRODUCT_CUSTOM_IMAGE_MAKEFILES += \
   device/mediatek/common/build/custom_images/persist.mk

# copy persist prebuilt images
PRODUCT_COPY_FILES += \
    device/mediatek/common/binaries/persist.img:$(TARGET_OUT)/persist.img

# AVB
ifeq ($(TARGET_BUILD_VARIANT), user)
TARGET_AVB_ENABLE := true
endif

# Health: Install default binderized implementation to vendor.
PRODUCT_PACKAGES += android.hardware.health-service.batteryless

# Backlight/brightness
PRODUCT_PACKAGES += android.hardware.lights-service

# Thermal
PRODUCT_PACKAGES += android.hardware.thermal@2.0-service.mediatek

#enforce permission allowlists for system apps.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=enforce

PRODUCT_PRODUCT_PROPERTIES += ro.incremental.enable=yes

# CTS
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.cts.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.cts.xml

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack-service.example

# DRM (Digital Rights Management)
PRODUCT_PACKAGES += \
    android.hardware.drm@latest-service.clearkey

# app widget, needed for default launcher3
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \

# Power HAL
PRODUCT_PACKAGES += android.hardware.power-service.example

# Add support for common utils
$(call inherit-product, device/mediatek/common/utils/utils.mk)

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)
# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0 \
	android.hardware.fastboot@1.0-impl-mock \
	fastbootd

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service \
    bootctrl.default

PRODUCT_PACKAGES_DEBUG += \
    bootctl

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

#Increase JVM heap size
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapsize=256m

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Display settings (windowing, system decorations, IME ...)
PRODUCT_COPY_FILES += \
    device/mediatek/common/etc/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings.xml

# GPIO utils
PRODUCT_PACKAGES_DEBUG += gpioinfo gpioget gpioset

# Use not updatable APEXes
PRODUCT_PROPERTY_OVERRIDES += ro.apex.updatable=false

# Kernel
$(call inherit-product, device/mediatek/common/kernel/device.mk)

# Filesystems
$(call inherit-product, device/mediatek/common/fs/device.mk)

# Recovery
$(call inherit-product, device/mediatek/common/recovery/device.mk)

# Audio
$(call inherit-product, device/mediatek/common/audio/device.mk)

# USB
$(call inherit-product, device/mediatek/common/usb/device.mk)

# Graphics
$(call inherit-product, device/mediatek/common/graphics/device.mk)

# Security
$(call inherit-product, device/mediatek/common/security/device.mk)

# Media
$(call inherit-product, device/mediatek/common/media/device.mk)
