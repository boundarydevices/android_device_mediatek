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
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

$(call inherit-product, device/mediatek/common/mt8167/mt8167.mk)

PRODUCT_NAME := i300a_sb30
PRODUCT_DEVICE := i300a_sb30
PRODUCT_BRAND := Android
PRODUCT_MODEL := i300a_sb30
PRODUCT_MANUFACTURER := mediatek

$(call inherit-product, device/mediatek/board/i300a_sb30/device.mk)
