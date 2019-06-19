#
# Copyright 2019 BayLibre SAS
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
LOCAL_KERNEL := device/mediatek/mt8167-kernel/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

$(call inherit-product-if-exists, vendor/mediatek/mt8167/device-vendor.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8167.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8167.rc \
    $(LOCAL_PATH)/init.mt8167.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8167.usb.rc \
    $(LOCAL_PATH)/fstab.mt8167:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8167

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service \
    android.hardware.health@2.0-service.default
