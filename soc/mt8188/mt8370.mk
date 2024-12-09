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

$(call inherit-product, device/mediatek/soc/mt8188/mt8188.mk)

# Specify the model
PRODUCT_PRODUCT_PROPERTIES += \
    ro.soc.manufacturer=mediatek \
    ro.soc.model=mt8370

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8188.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8370.rc

# Fstab
MTK_FSTAB := fstab.mt8370

