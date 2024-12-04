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

# OP-TEE
ifeq ($(OPTEE_ENABLE), true)
$(call inherit-product, $(LOCAL_PATH)/optee/device.mk)
else
PRODUCT_PROPERTY_OVERRIDES += ro.vendor.keymaster.optee=disabled
endif

# Keyaster / Gatekeeper
ifeq ($(OPTEE_KEYMASTER_GATEKEEPER_ENABLE), true)
$(call inherit-product, $(LOCAL_PATH)/optee/kmgk.mk)
else
$(call inherit-product, $(LOCAL_PATH)/soft/kmgk.mk)
endif
