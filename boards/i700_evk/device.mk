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

# Features supported only for kernel 6.12
ifeq ($(TARGET_KERNEL_USE), 6.12)
# Bluetooth
$(call inherit-product, device/mediatek/bluetooth/mt7921/mt7921.mk)

# WiFi
$(call inherit-product, device/mediatek/wifi/mt7921/mt7921.mk)

# Audio
$(call inherit-product, device/mediatek/audio/device.mk)
PRODUCT_PACKAGES += audio.primary.i700_evk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/xml/audio_policy_configuration-i700_evk.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/xml/audio_hal_configuration-i700_evk.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio.i700_evk.xml
endif

# ueventd
PRODUCT_COPY_FILES += \
    device/mediatek/boards/i700_evk/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc
