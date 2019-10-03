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
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, device/mediatek/common/soc/mt8167/mt8167.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.pumpkin.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.pumpkin.rc \
    $(LOCAL_PATH)/fstab.pumpkin:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.pumpkin

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=180

PRODUCT_NAME := pumpkin
PRODUCT_DEVICE := pumpkin
PRODUCT_BRAND := Android
PRODUCT_MODEL := pumpkin
PRODUCT_MANUFACTURER := mediatek

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)
