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

# Shipping API level to Android 12 (S)
PRODUCT_SHIPPING_API_LEVEL := 31

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=180

# Audio: use a specific i350-pumpkin hal configuration with TinyHAL
PRODUCT_PACKAGES += audio.primary.i350_pumpkin
PRODUCT_COPY_FILES += \
     device/mediatek/common/mt8365/audio_xml/audio_policy_configuration-i350_pumpkin.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
     device/mediatek/common/mt8365/audio_xml/audio_hal_configuration-i350_pumpkin.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.i350_pumpkin.xml

DEVICE_PACKAGE_OVERLAYS := device/mediatek/board/i350_pumpkin/overlay

# Camera + ISP Firmwares:
PRODUCT_COPY_FILES += \
     external/onsemi/OLogic_Pumpkin_i500/ap1302_ar0330_single_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0330_single_fw.bin \
     external/onsemi/OLogic_Pumpkin_i500/ap1302_ar0144_single_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0144_single_fw.bin \
     external/onsemi/OLogic_Pumpkin_i500/ap1302_ar0144_dual_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0144_dual_fw.bin

# UVC camera
$(call inherit-product, hardware/mediatek/camera/uvc/uvc.mk)
# CSI camera
$(call inherit-product, hardware/mediatek/camera/csi/csi.mk)

$(call inherit-product, vendor/mediatek/wireless/mt7663.mk)

# splashscreen
PRODUCT_COPY_FILES += $(LOCAL_PATH)/splashscreen.img:splashscreen.img
