#
# Copyright 2020 BayLibre SAS
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

# optee
OPTEE_OS_DIR := external/optee-os
OPTEE_TA_TARGETS := ta_arm64
OPTEE_CFG_ARM64_CORE := y

CFG_TEE_SUPP_LOG_LEVEL := 4
CFG_SECSTOR_TA_MGMT_PTA := y
CFG_SECURE_DATA_PATH := y

BUILD_OPTEE_MK := external/optee-os/mk/aosp_optee.mk

PRODUCT_PACKAGES += \
    libteec \
    tee-supplicant

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.optee.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.optee.rc

# xtest
PRODUCT_PACKAGES_DEBUG += xtest
PRODUCT_PACKAGES_DEBUG += 12345678-5b69-11e4-9dbb-101f74f00099.ta # sdp_basic
PRODUCT_PACKAGES_DEBUG += 873bcd08-c2c3-11e6-a937-d0bf9c45c61c.ta # socket
PRODUCT_PACKAGES_DEBUG += 5b9e0e40-2636-11e1-ad9e-0002a5d5c51b.ta # os_test
PRODUCT_PACKAGES_DEBUG += ffd2bded-ab7d-4988-95ee-e4962fff7154.ta # os_test_lib
PRODUCT_PACKAGES_DEBUG += 5ce0c432-0ab0-40e5-a056-782ca0e6aba2.ta # concurrent_large
PRODUCT_PACKAGES_DEBUG += b689f2a7-8adf-477a-9f99-32e90c0ad0a2.ta # storage
PRODUCT_PACKAGES_DEBUG += ee90d523-90ad-46a0-859d-8eea0b150086.ta # tpm_log_test
PRODUCT_PACKAGES_DEBUG += c3f6e2c0-3548-11e1-b86c-0800200c9a66.ta # create_fail_test
PRODUCT_PACKAGES_DEBUG += 731e279e-aafb-4575-a771-38caa6f0cca6.ta # storage2
PRODUCT_PACKAGES_DEBUG += cb3e5ba0-adf1-11e0-998b-0002a5d5c51b.ta # crypt
PRODUCT_PACKAGES_DEBUG += d17f73a0-36ef-11e1-984a-0002a5d5c51b.ta # rpc_test
PRODUCT_PACKAGES_DEBUG += f157cda0-550c-11e5-a6fa-0002a5d5c51b.ta # storage_benchmark
PRODUCT_PACKAGES_DEBUG += e626662e-c0e2-485c-b8c8-09fbce6edf3d.ta # aes_perf
PRODUCT_PACKAGES_DEBUG += e13010e0-2ae1-11e5-896a-0002a5d5c51b.ta # concurrent
PRODUCT_PACKAGES_DEBUG += b3091a65-9751-4784-abf7-0298a7cc35ba.ta # os_test_lib_dl
PRODUCT_PACKAGES_DEBUG += a4c04d50-f180-11e8-8eb2-f2801f1b9fd1.ta # sims_keepalive
PRODUCT_PACKAGES_DEBUG += 614789f2-39c0-4ebf-b235-92b32ac107ed.ta # sha_perf
PRODUCT_PACKAGES_DEBUG += 528938ce-fc59-11e8-8eb2-f2801f1b9fd1.ta # miss
PRODUCT_PACKAGES_DEBUG += e6a33ed4-562b-463a-bb7e-ff5e15a493c8.ta # sims
