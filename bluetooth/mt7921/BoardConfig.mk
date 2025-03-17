
#
# Copyright 2025 BayLibre SAS
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

include device/mediatek/bluetooth/BoardConfig.mk

# Kernel modules
BOARD_VENDOR_KERNEL_MODULES += \
    $(GOOGLE_KERNEL_DIST)/bluetooth.ko \
    $(GOOGLE_KERNEL_DIST)/btbcm.ko \
    $(MTK_KERNEL_DIST)/btintel.ko \
    $(MTK_KERNEL_DIST)/btrtl.ko \
    $(MTK_KERNEL_DIST)/btmtk.ko \
    $(MTK_KERNEL_DIST)/btusb.ko
