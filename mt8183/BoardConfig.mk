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
include device/mediatek/common/BoardConfigCommon.mk

TARGET_CPU_VARIANT := cortex-a73

BOARD_MKBOOTIMG_ARGS := \
  --kernel_offset $(BOARD_KERNEL_OFFSET) \
  --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
  --tags_offset $(BOARD_TAGS_OFFSET) \
  --header_version 2

BOARD_SEPOLICY_DIRS += \
        device/mediatek/common/mt8183/sepolicy \

BOARD_SEPOLICY_DIRS += \
    device/mediatek/common/optee/sepolicy/30.0/vendor

DEVICE_MANIFEST_FILE += device/mediatek/common/mt8183/manifest.xml

VENDOR_UEVENTD_FILES += device/mediatek/common/mt8183/ueventd.mt8183.rc

# RecoveryOS
TARGET_RELEASETOOLS_EXTENSIONS := device/mediatek/common/

# Recovery
ifeq ($(TARGET_AVB_ENABLE), true)
TARGET_RECOVERY_FSTAB := device/mediatek/common/mt8183/fstab.mt8183.avb
else
TARGET_RECOVERY_FSTAB := device/mediatek/common/mt8183/fstab.mt8183
endif

# Vulkan
BOARD_INSTALL_VULKAN := true

SOONG_CONFIG_NAMESPACES += arm_gralloc
SOONG_CONFIG_arm_gralloc += \
		gralloc_hwc_force_bgra_8888 \
		gralloc_hwc_fb_disable_afbc \
		gralloc_camera_write_raw16 \
		gralloc_use_ion_dma_heap \
		gralloc_use_ion_compound_page_heap \
		gralloc_init_afbc \
		gralloc_use_ion_dmabuf_sync \
		mali_video_version \
		mali_gpu_support_afbc_basic \
		mali_gpu_support_afbc_splitblk \
		mali_gpu_support_afbc_wideblk \
		mali_gpu_support_afbc_tiled_headers \
		mali_gpu_support_afbc_yuv_write \
		gralloc_arm_no_external_afbc

SOONG_CONFIG_arm_gralloc_mali_video_version := v550
SOONG_CONFIG_arm_gralloc_mali_gpu_support_afbc_basic := false
SOONG_CONFIG_arm_gralloc_mali_gpu_support_afbc_splitblk := false
SOONG_CONFIG_arm_gralloc_mali_gpu_support_afbc_wideblk := false
SOONG_CONFIG_arm_gralloc_mali_gpu_support_afbc_tiled_headers := false
SOONG_CONFIG_arm_gralloc_mali_gpu_support_afbc_yuv_write := false
SOONG_CONFIG_arm_gralloc_gralloc_arm_no_external_afbc := true
SOONG_CONFIG_arm_gralloc_gralloc_use_ion_dma_heap := true
SOONG_CONFIG_arm_gralloc_gralloc_use_ion_compound_page_heap := false
SOONG_CONFIG_arm_gralloc_gralloc_init_afbc := false
SOONG_CONFIG_arm_gralloc_gralloc_hwc_force_bgra_8888 := false
SOONG_CONFIG_arm_gralloc_gralloc_use_ion_dmabuf_sync := true
SOONG_CONFIG_arm_gralloc_gralloc_hwc_fb_disable_afbc := true
SOONG_CONFIG_arm_gralloc_gralloc_camera_write_raw16 := false
