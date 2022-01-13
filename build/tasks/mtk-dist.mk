#necessary files for aiot-flash
INTERNAL_IMG_PACKAGE_FILES := \
	$(PRODUCT_OUT)/bl2.img \
	$(PRODUCT_OUT)/fip.bin \
	$(PRODUCT_OUT)/flashproc.py \
	$(PRODUCT_OUT)/lk.bin \
	$(PRODUCT_OUT)/MBR_EMMC \
	$(PRODUCT_OUT)/partitions.yaml \
	$(PRODUCT_OUT)/persist.img \
	$(PRODUCT_OUT)/splashscreen.raw \
	$(PRODUCT_OUT)/u-boot-initial-env \
	$(PRODUCT_OUT)/android-info.txt \
	$(PRODUCT_OUT)/boot.img \
	$(PRODUCT_OUT)/dtbo.img \
	$(PRODUCT_OUT)/super.img \
	$(PRODUCT_OUT)/userdata.img \

ifeq ($(TARGET_AVB_ENABLE), true)
INTERNAL_IMG_PACKAGE_FILES += \
	$(PRODUCT_OUT)/vbmeta.img
endif

ifneq ($(TARGET_USE_AB_SLOT), true)
INTERNAL_IMG_PACKAGE_FILES += \
	$(PRODUCT_OUT)/cache.img \
	$(PRODUCT_OUT)/recovery.img
endif

# The update package
dbg :=
ifeq ($(TARGET_BUILD_TYPE),debug)
  dbg := "_debug"
endif
name := $(TARGET_PRODUCT)$(dbg)-img-mtk-$(FILE_NAME_TAG)

MTK_INTERNAL_UPDATE_PACKAGE_TARGET := $(PRODUCT_OUT)/$(name).zip
$(MTK_INTERNAL_UPDATE_PACKAGE_TARGET): $(INTERNAL_IMG_PACKAGE_FILES)
	$(info Package: $@)
	$(hide) $(SOONG_ZIP) -o $@ -C $(dir $<) $(addprefix -f ,$^)
.PHONY: mtk-dist
mtk-dist: $(MTK_INTERNAL_UPDATE_PACKAGE_TARGET)
