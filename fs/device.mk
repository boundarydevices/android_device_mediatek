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

# Dynamic partitions
PRODUCT_BUILD_SUPER_PARTITION := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

# f2fs
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# fstab
ifeq ($(MTK_FSTAB),)
$(error MTK_FSTAB not set)
endif

ifeq ($(TARGET_AVB_ENABLE), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.avb:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/$(MTK_FSTAB).avb \
    $(LOCAL_PATH)/fstab.avb:$(TARGET_COPY_OUT_VENDOR)/etc/$(MTK_FSTAB).avb
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/$(MTK_FSTAB) \
    $(LOCAL_PATH)/fstab:$(TARGET_COPY_OUT_VENDOR)/etc/$(MTK_FSTAB)
endif
