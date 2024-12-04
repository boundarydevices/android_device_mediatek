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

# common mediatek board
$(call inherit-product, device/mediatek/boards/board.mk)

# Audio: use a specific i350-evk hal configuration with TinyHAL
PRODUCT_PACKAGES += audio.primary.i350_evk
PRODUCT_COPY_FILES += \
     device/mediatek/soc/mt8365/audio_xml/audio_policy_configuration-i350_evk.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
     device/mediatek/soc/mt8365/audio_xml/audio_hal_configuration-i350_evk.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.i350_evk.xml

DEVICE_PACKAGE_OVERLAYS := device/mediatek/boards/i350_evk/overlay

# Camera + ISP Firmwares:
PRODUCT_COPY_FILES += \
     external/onsemi/MediaTek_AIoT_i350_EVK/ap1302_ar0430_single_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ap1302_ar0430_single_fw.bin

# UVC camera
$(call inherit-product, hardware/mediatek/camera/uvc/uvc.mk)
# CSI camera
$(call inherit-product, hardware/mediatek/camera/csi/csi.mk)

$(call inherit-product, vendor/mediatek/wireless/mt7663.mk)

# splashscreen
PRODUCT_COPY_FILES += $(LOCAL_PATH)/splashscreen.img:splashscreen.img

# ueventd
PRODUCT_COPY_FILES += \
    device/mediatek/boards/i350_evk/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc
