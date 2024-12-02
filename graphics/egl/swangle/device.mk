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

# SwAngle
PRODUCT_REQUIRES_INSECURE_EXECMEM_FOR_SWIFTSHADER := true

PRODUCT_PACKAGES := \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle \
    vulkan.pastel

PRODUCT_VENDOR_PROPERTIES := \
    ro.hardware.egl=angle \
    ro.hardware.vulkan=pastel

# SwAngle on vendor
$(call soong_config_set,angle,angle_on_system,false)

PRODUCT_VENDOR_PROPERTIES += ro.gfx.angle.supported=true
