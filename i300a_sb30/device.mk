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


# Shipping API level to Android R (30)
PRODUCT_SHIPPING_API_LEVEL := 30

# Audio: use default hal configuration with TinyHAL
PRODUCT_PACKAGES += audio.primary.i300a_sb30
PRODUCT_COPY_FILES += \
     device/mediatek/common/soc/mt8167/audio_xml/audio_hal_configuration_jack.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.i300a_sb30.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=180

DEVICE_PACKAGE_OVERLAYS := device/mediatek/board/i300a_sb30/overlay

# mark device as "low ram"
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)

# UVC camera
$(call inherit-product, device/mediatek/common/hal/camera/uvc/uvc.mk)
