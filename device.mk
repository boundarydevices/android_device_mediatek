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

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.opal.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.opal.rc \
    $(LOCAL_PATH)/fstab.opal:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.opal

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=360

# Splashscreen: use default one
PRODUCT_COPY_FILES += \
     device/mediatek/common/soc/mt8183/binaries/images/splashscreen.raw:splashscreen.raw

# Additional hardware features
$(call inherit-product-if-exists, vendor/mediatek/mt7668/mt7668.mk)
# Touchscreen
$(call inherit-product, vendor/goodix/goodix5688/goodix5688.mk)
