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

BOARD_VENDOR_KERNEL_MODULES += \
    $(GOOGLE_KERNEL_DIST)/libarc4.ko \
    $(GOOGLE_KERNEL_DIST)/rfkill.ko \
    $(MTK_KERNEL_DIST)/cfg80211.ko \
    $(MTK_KERNEL_DIST)/mac80211.ko
