#
# Copyright 2025 BayLibre SAS
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

$(call inherit-product, device/mediatek/wifi/wifi.mk)

# Firmware (from linux-firmware)
PRODUCT_COPY_FILES += \
    vendor/mediatek/prebuilts/linux-firmware/WIFI_MT7961_patch_mcu_1_2_hdr.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin \
    vendor/mediatek/prebuilts/linux-firmware/WIFI_RAM_CODE_MT7961_1.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/mediatek/WIFI_RAM_CODE_MT7961_1.bin
