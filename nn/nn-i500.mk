#
# Copyright 2022 BayLibre SAS
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

$(call inherit-product, $(LOCAL_PATH)/nn.mk)

GPU_PREBUILD_PRESENT := $(wildcard vendor/mediatek/prebuilts/egl/mali/i500)
ifneq "$(GPU_PREBUILD_PRESENT)" ""
ARMNN_COMPUTE_CL_ENABLE := 1
else
ARMNN_COMPUTE_CL_ENABLE := 0
endif

# Cadence Neural Networks HAL for VP6 acceleration
# This requires NDA to get access
$(call inherit-product-if-exists, vendor/cadence/prebuilts/i500/vp6.mk)

# Armnn properties
PRODUCT_PROPERTY_OVERRIDES += \
    Armnn.operandTypeTensorQuant8AsymmPerformance.execTime=2 \
    Armnn.operandTypeTensorQuant8AsymmPerformance.powerUsage=2 \
    Armnn.operandTypeTensorQuant8SymmPerformance.execTime=2 \
    Armnn.operandTypeTensorQuant8SymmPerformance.powerUsage=2 \
    Armnn.operandTypeTensorQuant8SymmPerChannelPerformance.execTime=2 \
    Armnn.operandTypeTensorQuant8SymmPerChannelPerformance.powerUsage=2

# Install gpu tuning file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/armnn/gpu-tuner-file.csv:$(TARGET_COPY_OUT_VENDOR)/etc/gpu-tuner-file.csv
