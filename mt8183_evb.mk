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
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, device/mediatek/common/soc/mt8183/mt8183.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8183_evb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8183_evb.rc \
    $(LOCAL_PATH)/fstab.mt8183_evb:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8183_evb

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=360

# Touchscreen
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/touchscreen/goodix_5688_cfg.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/goodix_5688_cfg.bin \
    $(LOCAL_PATH)/touchscreen/init.goodix.rc:$(TARGET_COPY_OUT_VENDOR)//etc/init/init.goodix.rc \

# Splashscreen: use default one
PRODUCT_COPY_FILES += \
     device/mediatek/common/soc/mt8183/binaries/images/splashscreen.raw:splashscreen.raw

PRODUCT_NAME := mt8183_evb
PRODUCT_DEVICE := mt8183_evb
PRODUCT_BRAND := Android
PRODUCT_MODEL := mt8183_evb
PRODUCT_MANUFACTURER := mediatek

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)
