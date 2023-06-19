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
TARGET_KERNEL_USE=5.10
endif

# Disable kernel config check for now
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/mediatek/boards-binaries/$(TARGET_KERNEL_USE)/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Specify the manufacturer
PRODUCT_PRODUCT_PROPERTIES += \
    ro.soc.manufacturer=mediatek

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mediatek.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.rc \
    $(LOCAL_PATH)/init.mediatek.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.usb.rc \
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
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl-batteryless

# Backlight/brightness
PRODUCT_PACKAGES += android.hardware.lights-service

# Thermal
PRODUCT_PACKAGES += android.hardware.thermal@2.0-service.mediatek

# Security
ifeq ($(OPTEE_ENABLE), true)
$(call inherit-product, $(LOCAL_PATH)/optee/device-optee.mk)
else
PRODUCT_PROPERTY_OVERRIDES += ro.vendor.keymaster.optee=disabled
endif

ifeq ($(TEE_KEYMASTER_GATEKEEPER_ENABLE), true)
$(call inherit-product, $(LOCAL_PATH)/optee/kmgk.mk)
else
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service \
    android.hardware.gatekeeper@1.0-service.software
endif

# mt8183 has OpenGL ES version (3.2)
# this value should be moved in specific soc folder if it's not aligned in next deliveries
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196610

#enforce permission allowlists for system apps.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=enforce

PRODUCT_PRODUCT_PROPERTIES += ro.incremental.enable=yes

# Audio:
# NOTE: each product should also add audio.primary.$(TARGET_DEVICE) to its PRODUCT_PACKAGES
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:vendor/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:vendor/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:vendor/etc/audio_effects.xml

# CTS
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.cts.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.cts.xml

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack-service.example

# DRM (Digital Rights Management)
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.2-service.mtk

PRODUCT_COPY_FILES += \
    hardware/mediatek/usb/1.2/init.gadgethal.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.gadgethal.sh

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \

# app widget, needed for default launcher3
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \

# Screen features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.portrait.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.portrait.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml

# Vulkan
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:vendor/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:vendor/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:vendor/etc/permissions/android.software.vulkan.deqp.level.xml


# RecoveryOS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.mediatek.rc:recovery/root/vendor/etc/init/init.recovery.mediatek.rc

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    hardware/mediatek/media_xml/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml

# Power HAL
PRODUCT_PACKAGES += android.hardware.power-service.example

# Add support for common utils: vendor ueventd.rc and (optional) debug tools
$(call inherit-product, device/mediatek/common/utils/utils.mk)

# ion permissions
VENDOR_UEVENTD_FILES += vendor/mediatek/prebuilts/egl/ueventd.rc

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
	frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
	frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
	frameworks/native/data/etc/android.software.autofill.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.autofill.xml

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
