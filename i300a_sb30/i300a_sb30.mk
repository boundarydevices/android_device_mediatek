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

# All OP-TEE vars MUST be set before including common/mt*
OPTEE_ENABLE := true
TEE_KEYMASTER_GATEKEEPER_ENABLE := true

include device/mediatek/common/common-build-flags.mk

$(call inherit-product, device/mediatek/common/mt8167/mt8167.mk)

PRODUCT_NAME := i300a_sb30
PRODUCT_DEVICE := i300a_sb30
PRODUCT_BRAND := Android
PRODUCT_MODEL := i300a_sb30
PRODUCT_MANUFACTURER := mediatek

$(call inherit-product, device/mediatek/board/i300a_sb30/device.mk)

# bootloaders binaries
$(call copy_bl_binaries, device/mediatek/common/mt8167/binaries/images)

# clean-up all unknown PRODUCT_PACKAGES
allowed_list := product_manifest.xml
$(call enforce-product-packages-exist, $(allowed_list))

# OP-TEE Trusted Applications
ifeq ($(OPTEE_ENABLE), true)
include device/mediatek/common/optee/device-optee.mk

I300A_SB30_TA := device/mediatek/common/mt8167/binaries/images/optee-ta

ifeq ($(TEE_KEYMASTER_GATEKEEPER_ENABLE), true)
# gatekeeper
$(call optee-add-ta, $(I300A_SB30_TA)/4d573443-6a56-4272-ac6f-2425af9ef9bb.ta)
# keymaster
$(call optee-add-ta, $(I300A_SB30_TA)/dba51a17-0563-11e7-93b1-6fa7b0071a51.ta)
endif

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# supp_plugin
$(call optee-add-ta, $(I300A_SB30_TA)/380231ac-fb99-47ad-a689-9e017eb6e78a.ta)
# xtest
$(call optee-add-all-xtest-ta, $(I300A_SB30_TA))
endif
endif
