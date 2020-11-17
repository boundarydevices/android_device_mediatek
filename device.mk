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

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=360

# Splashscreen: use default one
PRODUCT_COPY_FILES += \
     device/mediatek/common/soc/mt8183/binaries/images/splashscreen.raw:splashscreen.raw

# Audio: use default hal configuration with TinyHAL
PRODUCT_PACKAGES += audio.primary.quartz
PRODUCT_COPY_FILES += \
     device/mediatek/common/soc/mt8183/audio_xml/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.quartz.xml

PRODUCT_COPY_FILES += \
     device/mediatek/quartz/ILI210x_Touchscreen.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/ILI210x_Touchscreen.idc

# Touchscreen: add 90CCW rotation config file
PRODUCT_COPY_FILES += \
     device/mediatek/quartz/input-manager-state.xml:$(TARGET_COPY_OUT_DATA)/system/input-manager-state.xml

# Key Layout files
PRODUCT_COPY_FILES += \
     device/mediatek/quartz/mtk-pmic-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/mtk-pmic-keys.kl

# Shipping API level to Android R (30)
PRODUCT_SHIPPING_API_LEVEL := 30

# DEVICE_PACKAGE_OVERLAYS for the device should be before
# including common overlays since the one listed first
# takes precedence.
ifdef DEVICE_PACKAGE_OVERLAYS
$(warning Overlays defined in '$(DEVICE_PACKAGE_OVERLAYS)' will override '$(PRODUCT_HARDWARE)' overlays)
endif
DEVICE_PACKAGE_OVERLAYS += device/mediatek/quartz/overlay

# Demo apps
PRODUCT_PACKAGES += \
    DemoCheckoutCounter

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=64m \
    dalvik.vm.heapsize=64m

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)
# Touchscreen
$(call inherit-product, vendor/ilitek/ili251x/ili251x.mk)
# Camera
$(call inherit-product, vendor/onsemi/ap1302/ap1302.mk)
