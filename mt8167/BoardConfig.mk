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
include device/mediatek/common/soc/BoardConfigCommon.mk

TARGET_CPU_VARIANT := cortex-a53


BOARD_MKBOOTIMG_ARGS := \
  --base $(BOARD_KERNEL_BASE) \
  --kernel_offset $(BOARD_KERNEL_OFFSET) \
  --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
  --tags_offset $(BOARD_TAGS_OFFSET) \
  --header_version 2

BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/mediatek/common/soc/mt8167/bluetooth

# Recovery
ifeq ($(TARGET_USE_AB_SLOT), true)
ifeq ($(TARGET_AVB_ENABLE), true)
TARGET_RECOVERY_FSTAB := device/mediatek/common/soc/mt8167/fstab.mt8167.avb.ab
else
TARGET_RECOVERY_FSTAB := device/mediatek/common/soc/mt8167/fstab.mt8167.ab
endif
else
ifeq ($(TARGET_AVB_ENABLE), true)
TARGET_RECOVERY_FSTAB := device/mediatek/common/soc/mt8167/fstab.recovery.mt8167.avb
else
TARGET_RECOVERY_FSTAB := device/mediatek/common/soc/mt8167/fstab.recovery.mt8167
endif
endif
