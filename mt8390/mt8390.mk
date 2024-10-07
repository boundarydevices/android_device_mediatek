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

$(call inherit-product, device/mediatek/common/device.mk)

# Specify the model
PRODUCT_PRODUCT_PROPERTIES += \
    ro.soc.model=i700

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8390.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8390.rc

# fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt8390:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt8390 \
    $(LOCAL_PATH)/fstab.mt8390:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8390

# OP-TEE
OPTEE_PLATFORM := mediatek-mt8188
OPTEE_PLATFORM_FLAVOR := mt8188
OPTEE_CFG_DRAM_SIZE := 0xc0000000
