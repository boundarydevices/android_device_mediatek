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
    ro.sf.lcd_density=200 \

PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi
# Splashscreen: use default one
PRODUCT_COPY_FILES += \
     device/mediatek/common/soc/mt8183/binaries/images/splashscreen.raw:splashscreen.raw

# Touchscreen: add 90CCW rotation config file
PRODUCT_COPY_FILES += \
     device/mediatek/quartz/input-manager-state.xml:$(TARGET_COPY_OUT_DATA)/system/input-manager-state.xml \
     device/mediatek/quartz/tablet_core_hardware_quartz.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tablet_core_hardware_quartz.xml \
     frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \
     frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml \
     frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
     frameworks/native/data/etc/android.software.print.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.print.xml \
     frameworks/native/data/etc/android.software.webview.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.webview.xml \
     frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

# Key Layout files
PRODUCT_COPY_FILES += \
     device/mediatek/quartz/mtk-pmic-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/mtk-pmic-keys.kl

# Shipping API level to Android Q (29)
PRODUCT_SHIPPING_API_LEVEL := 29

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

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)
# Touchscreen
$(call inherit-product, vendor/ilitek/ili251x/ili251x.mk)
# UVC camera
$(call inherit-product, device/mediatek/common/uvc/uvc.mk)
