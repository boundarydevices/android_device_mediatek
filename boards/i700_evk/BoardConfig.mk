#
# Copyright 2014 The Android Open-Source Project
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

include device/mediatek/soc/mt8188/BoardConfig.mk

TARGET_BOOTLOADER_BOARD_NAME := i700_evk

# kernel commandline
BOARD_KERNEL_CMDLINE += \
    androidboot.boot_devices=soc/11230000.mmc \
    androidboot.hardware=mt8390 \
    androidboot.serialno=i700evk

# FS configuration
# FIXME: This should be adjusted to i700_evk
BOARD_SUPER_PARTITION_SIZE         := 4831838208
BOARD_DTBOIMG_PARTITION_SIZE       := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_DB_DYNAMIC_PARTITIONS_SIZE   := 2411724800

MTK_PARTITIONS_YAML := device/mediatek/boards/i700_evk/partitions.yaml

# Please keep this list fixed: add new files in the end of the list
DTB_FILES := \
    $(LOCAL_DTB)/mt8390-genio-700-evk.dtb

# Please keep this list fixed: add new files in the end of the list
DTBO_FILES := \
    $(LOCAL_DTB)/mt8390-genio-700-evk-android.dtb
