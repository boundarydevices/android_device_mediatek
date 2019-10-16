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

$(call inherit-product, device/mediatek/common/soc/device-common.mk)

# Flashing tool + prebuilt binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/dl_addr.ini:dl_addr.ini \
    $(LOCAL_PATH)/binaries/images/lk.bin:lk.bin \
    $(LOCAL_PATH)/binaries/images/bl2.img:bl2.img \
    $(LOCAL_PATH)/binaries/images/fip.bin:fip.bin \
    $(LOCAL_PATH)/binaries/images/u-boot-initial-env:u-boot-initial-env
