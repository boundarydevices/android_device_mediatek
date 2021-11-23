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
     device/mediatek/common/mt8183/binaries/images/splashscreen.raw:splashscreen.raw

# Audio: use default hal configuration with TinyHAL
PRODUCT_PACKAGES += audio.primary.i500_pumpkin
PRODUCT_COPY_FILES += \
     device/mediatek/common/mt8183/audio_xml/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.i500_pumpkin.xml

PRODUCT_COPY_FILES += \
     device/mediatek/board/i500_pumpkin/ILI210x_Touchscreen.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/ILI210x_Touchscreen.idc

# Key Layout files
PRODUCT_COPY_FILES += \
     device/mediatek/board/i500_pumpkin/mtk-pmic-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/mtk-pmic-keys.kl

# Camera firmwares
PRODUCT_COPY_FILES += \
    external/onsemi/OLogic_Pumpkin_i500//ap1302_ar0330_single_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0330_single_fw.bin \
    external/onsemi/OLogic_Pumpkin_i500//ap1302_ar0144_single_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0144_single_fw.bin \
    external/onsemi/OLogic_Pumpkin_i500//ap1302_ar0144_dual_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0144_dual_fw.bin

# Shipping API level to Android R (30)
PRODUCT_SHIPPING_API_LEVEL := 30

# DEVICE_PACKAGE_OVERLAYS for the device should be before
# including common overlays since the one listed first
# takes precedence.
ifdef DEVICE_PACKAGE_OVERLAYS
$(warning Overlays defined in '$(DEVICE_PACKAGE_OVERLAYS)' will override '$(PRODUCT_HARDWARE)' overlays)
endif
DEVICE_PACKAGE_OVERLAYS += device/mediatek/board/i500_pumpkin/overlay

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/wireless/mt7668.mk)
# Touchscreen
$(call inherit-product, vendor/ilitek/ili251x.mk)
# UVC camera
$(call inherit-product, hardware/mediatek/camera/uvc/uvc.mk)
# CSI camera
$(call inherit-product, hardware/mediatek/camera/csi/csi.mk)
