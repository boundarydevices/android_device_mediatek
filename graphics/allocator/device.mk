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

# Backend
TARGET_ALLOCATOR_BACKEND ?= arm
ifeq ($(TARGET_ALLOCATOR_BACKEND), arm)
$(call inherit-product, device/mediatek/graphics/allocator/arm/device.mk)
else ifeq ($(TARGET_ALLOCATOR_BACKEND), minigbm)
$(call inherit-product, device/mediatek/graphics/allocator/minigbm/device.mk)
else
$(error TARGET_ALLOCATOR_BACKEND not supported)
endif
