#
# Copyright 2021 BayLibre SAS
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

$(call inherit-product, device/mediatek/common/mt8365/mt8365.mk)

PRODUCT_NAME := i350_evk
PRODUCT_DEVICE := i350_evk
PRODUCT_BRAND := Android
PRODUCT_MODEL := i350_evk
PRODUCT_MANUFACTURER := mediatek

$(call inherit-product, device/mediatek/boards/i350_evk/device.mk)

# bootloaders binaries
$(call copy_bl_binaries, device/mediatek/boards-binaries/i350_evk)

# clean-up all unknown PRODUCT_PACKAGES
allowed_list := product_manifest.xml
allowed_list += android.hardware.health@2.0-impl-default.recovery
allowed_list += DeviceDiagnostics
$(call enforce-product-packages-exist, $(allowed_list))

# OP-TEE Trusted Applications
ifeq ($(OPTEE_ENABLE), true)
include device/mediatek/common/security/optee/device.mk

I350_EVK_TA := device/mediatek/boards-binaries/i350_evk/optee-ta

ifeq ($(TEE_KEYMASTER_GATEKEEPER_ENABLE), true)
# gatekeeper
$(call optee-add-ta, $(I350_EVK_TA)/4d573443-6a56-4272-ac6f-2425af9ef9bb.ta)
# keymaster
$(call optee-add-ta, $(I350_EVK_TA)/dba51a17-0563-11e7-93b1-6fa7b0071a51.ta)
endif

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# supp_plugin
$(call optee-add-ta, $(I350_EVK_TA)/380231ac-fb99-47ad-a689-9e017eb6e78a.ta)
# xtest
$(call optee-add-all-xtest-ta, $(I350_EVK_TA))
endif
endif
