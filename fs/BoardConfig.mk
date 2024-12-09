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

# sepolicy
BOARD_SEPOLICY_DIRS += device/mediatek/fs/sepolicy

# user images ext4
TARGET_USERIMAGES_USE_EXT4 := true

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# A/B OTA support
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := boot dtbo

# Dynamic partitions
TARGET_USE_DYNAMIC_PARTITIONS := true

# Super
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_PARTITION_GROUPS := db_dynamic_partitions
BOARD_SUPER_PARTITION_METADATA_DEVICE := super
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true

# System
BOARD_DB_DYNAMIC_PARTITIONS_PARTITION_LIST += system
AB_OTA_PARTITIONS += system

# Vendor
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
AB_OTA_PARTITIONS += vendor
BOARD_DB_DYNAMIC_PARTITIONS_PARTITION_LIST += vendor

# Metadata
BOARD_USES_METADATA_PARTITION := true

# vbmeta
ifeq ($(TARGET_AVB_ENABLE), true)
AB_OTA_PARTITIONS += vbmeta
endif

# Userdata
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# WARNING: do *NOT* edit BOARD_USERDATAIMAGE_PARTITION_SIZE
# the userdata partition will automatically take the remaining eMMC space
# since it's the last partition in the partitioning table
MTK_PRODUCT_OUT := $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)
BOARD_USERDATAIMAGE_PARTITION_SIZE = $(shell \
	mkdir -p $(MTK_PRODUCT_OUT); \
	python3  vendor/mediatek/tools/mbr/gen_partition_xml.py \
	$(MTK_PARTITIONS_YAML) $(MTK_PRODUCT_OUT) \
	--cache $(BOARD_CACHEIMAGE_PARTITION_SIZE) \
	--boot $(BOARD_BOOTIMAGE_PARTITION_SIZE) \
	--recovery $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) \
	--product $(BOARD_PRODUCTIMAGE_PARTITION_SIZE) \
	--oem $(BOARD_OEMIMAGE_PARTITION_SIZE) \
	--dtbo $(BOARD_DTBOIMG_PARTITION_SIZE) \
	--super $(BOARD_SUPER_PARTITION_SIZE); \
	awk '/userdata:/ || /userdata_a:/ {flag=1} flag && /size:/{print $$NF;flag="";exit}' \
	${MTK_PRODUCT_OUT}/partitions.yaml)
