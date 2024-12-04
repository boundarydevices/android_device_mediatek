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

include device/mediatek/BoardConfig.mk

TARGET_CPU_VARIANT := cortex-a53

BOARD_SEPOLICY_DIRS += \
        device/mediatek/soc/mt8365/sepolicy

# Recovery
ifeq ($(TARGET_AVB_ENABLE), true)
TARGET_RECOVERY_FSTAB := device/mediatek/soc/mt8365/fstab.mt8365.avb
else
TARGET_RECOVERY_FSTAB := device/mediatek/soc/mt8365/fstab.mt8365
endif
