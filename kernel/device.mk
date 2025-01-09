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

# Kernel version
TARGET_KERNEL_USE ?= 5.10

# Kernel Image
MTK_KERNEL_DIST := vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)
LOCAL_KERNEL := $(MTK_KERNEL_DIST)/Image
PRODUCT_COPY_FILES += $(LOCAL_KERNEL):kernel

# Disable kernel config check for now
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false
