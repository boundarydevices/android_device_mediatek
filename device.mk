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

# AVB
ifeq ($(TARGET_BUILD_VARIANT), user)
TARGET_AVB_ENABLE := true
endif

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

# Utils
$(call inherit-product, device/mediatek/common/utils/device.mk)

# Display
$(call inherit-product, device/mediatek/common/display/device.mk)

# Fastboot
$(call inherit-product, device/mediatek/common/fastboot/device.mk)

# Boot
$(call inherit-product, device/mediatek/common/boot/device.mk)

# Binaries
$(call inherit-product, device/mediatek/common/binaries/device.mk)

#######################################################################
#  Configs, properties, rc/xml files, modules/packages ...            #
#  not related to any feature folder are placed here.                 #
#######################################################################

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Specify the manufacturer
PRODUCT_PRODUCT_PROPERTIES += ro.soc.manufacturer=mediatek

# Enable Incremental on the device
PRODUCT_PRODUCT_PROPERTIES += ro.incremental.enable=yes

# Increase JVM heap size
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapsize=256m

# Enforce permission allowlists for system apps.
PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce

# Use not updatable APEXes
PRODUCT_PROPERTY_OVERRIDES += ro.apex.updatable=false

# Mediatek rc files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mediatek.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.rc \
    $(LOCAL_PATH)/init.lights.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.lights.rc

# Health: Install default binderized implementation to vendor.
PRODUCT_PACKAGES += android.hardware.health-service.batteryless

# Backlight/brightness
PRODUCT_PACKAGES += android.hardware.lights-service

# Thermal
PRODUCT_PACKAGES += android.hardware.thermal@2.0-service.mediatek

# Memtrack
PRODUCT_PACKAGES += android.hardware.memtrack-service.example

# DRM (Digital Rights Management)
PRODUCT_PACKAGES += android.hardware.drm@latest-service.clearkey

# Power HAL
PRODUCT_PACKAGES += android.hardware.power-service.example

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Persist prebuilt image
PRODUCT_CUSTOM_IMAGE_MAKEFILES += \
    device/mediatek/common/build/custom_images/persist.mk

PRODUCT_COPY_FILES += \
    device/mediatek/common/binaries/persist.img:$(TARGET_OUT)/persist.img

# CTS
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.cts.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.cts.xml

# app widget, needed for default launcher3
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \

# Copy xml file to support backup function
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml

# Copy xml file to support PIN, pattern and password LOck
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.secure_lock_screen.xml:system/etc/permissions/android.software.secure_lock_screen.xml

# Copy xml file to tell PackageManager that the system supports Verified Boot
ifeq ($(TARGET_AVB_ENABLE), true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml
endif

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
