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

$(call inherit-product-if-exists, vendor/mediatek/mt8183/device-vendor.mk)
$(call inherit-product, device/mediatek/common/soc/device-common.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audio/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/audio/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hal_configuration.xml \

# Flashing binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/lk.bin:$(TARGET_OUT)/lk.bin \
    $(LOCAL_PATH)/binaries/images/fip.bin:$(TARGET_OUT)/fip.bin \
    $(LOCAL_PATH)/binaries/images/bl2.img:$(TARGET_OUT)/bl2.img \
    $(LOCAL_PATH)/binaries/images/dl_addr.ini:$(TARGET_OUT)/dl_addr.ini \
    $(LOCAL_PATH)/binaries/images/u-boot-initial-env:$(TARGET_OUT)/u-boot-initial-env \
