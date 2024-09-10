#
# Copyright 2024 BayLibre SAS
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

# NOTE: each product should also add:
# PRODUCT_PACKAGES
# - audio.primary.$(TARGET_DEVICE)
# PRODUCT_COPY_FILES:
# - $(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml
# - $(TARGET_COPY_OUT_VENDOR)/etc/audio.$(TARGET_DEVICE).xml
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:vendor/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:vendor/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:vendor/etc/audio_effects.xml

# Low level audio tools for debugging
PRODUCT_PACKAGES_DEBUG += \
    tinymix \
    tinyplay \
    tinycap
