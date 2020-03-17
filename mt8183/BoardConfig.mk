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

TARGET_CPU_VARIANT := cortex-a73

BOARD_MKBOOTIMG_ARGS := \
  --kernel_offset $(BOARD_KERNEL_OFFSET) \
  --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
  --tags_offset $(BOARD_TAGS_OFFSET) \
  --header_version 1

BOARD_SEPOLICY_DIRS += \
        device/mediatek/common/soc/mt8183/sepolicy

DEVICE_MANIFEST_FILE += device/mediatek/common/soc/mt8183/manifest.xml

# RecoveryOS
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RELEASETOOLS_EXTENSIONS := device/mediatek/common/soc/
TARGET_RECOVERY_FSTAB := device/mediatek/common/soc/mt8183/fstab.recovery_noab.mt8183

ifeq ($(TARGET_USE_AB_SLOT), true)
TARGET_RECOVERY_FSTAB := device/mediatek/common/soc/mt8183/fstab.recovery_ab.mt8183
endif # eq $(TARGET_USE_AB_SLOT), true
