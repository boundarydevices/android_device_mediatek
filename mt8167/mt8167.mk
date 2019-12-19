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

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mt8167.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mt8167.rc \
    $(LOCAL_PATH)/fstab.mt8167:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt8167

# Flashing tool + prebuilt binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/dl_addr.ini:dl_addr.ini \
    $(LOCAL_PATH)/binaries/images/lk.bin:lk.bin

# BL2
ifneq ($(TARGET_USE_PRODUCT_SPECIFIC_BL2), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/bl2.img:$(TARGET_OUT)/bl2.img
endif # neq $(TARGET_USE_PRODUCT_SPECIFIC_BL2), true)

# U-Boot and env
ifneq ($(TARGET_USE_PRODUCT_SPECIFIC_UBOOT), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/binaries/images/fip.bin:fip.bin \
    $(LOCAL_PATH)/binaries/images/u-boot-initial-env:u-boot-initial-env
endif # neq $(TARGET_USE_PRODUCT_SPECIFIC_UBOOT), true)

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_xml/audio_hal_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hal_configuration.xml

# graphics bringup with swiftshader from Q preview
PRODUCT_COPY_FILES += \
    device/mediatek/common/binaries/egl/swiftshader/lib/libEGL_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libEGL_swiftshader.so \
    device/mediatek/common/binaries/egl/swiftshader/lib/libGLESv1_CM_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv1_CM_swiftshader.so \
    device/mediatek/common/binaries/egl/swiftshader/lib/libGLESv2_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv2_swiftshader.so \
    device/mediatek/common/binaries/egl/swiftshader/lib64/libEGL_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libEGL_swiftshader.so \
    device/mediatek/common/binaries/egl/swiftshader/lib64/libGLESv1_CM_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv1_CM_swiftshader.so \
    device/mediatek/common/binaries/egl/swiftshader/lib64/libGLESv2_swiftshader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv2_swiftshader.so \

# Gralloc
PRODUCT_PACKAGES += \
    gralloc.mtk
