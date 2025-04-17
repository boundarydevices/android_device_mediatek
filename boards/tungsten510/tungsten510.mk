#
# Copyright 2025 Ezurio LLC
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

# Kernel 6.12 + GKI
TARGET_KERNEL_USE := 6.12
MTK_USES_GKI := true
MTK_KERNEL_DIST := vendor/ezurio/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk

# Bootloader configuration
TARGET_MODE_BL := release
BOOTLOADERS_BINARIES := vendor/ezurio/prebuilts/boards/tungsten510

# All OP-TEE vars MUST be set before including common/mt*
OPTEE_ENABLE := true
OPTEE_KEYMASTER_GATEKEEPER_ENABLE := true

$(call inherit-product, device/mediatek/soc/mt8188/mt8370.mk)

PRODUCT_NAME := tungsten510
PRODUCT_DEVICE := tungsten510
PRODUCT_BRAND := Android
PRODUCT_MODEL := tungsten510
PRODUCT_MANUFACTURER := mediatek

$(call inherit-product, device/mediatek/boards/tungsten510/device.mk)

# clean-up all unknown PRODUCT_PACKAGES
allowed_list := product_manifest.xml
allowed_list += android.hardware.health@2.0-impl-default.recovery
allowed_list += DeviceDiagnostics
$(call enforce-product-packages-exist, $(allowed_list))
