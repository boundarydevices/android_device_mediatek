# Warning: this is actually a product definition, to be inherited from
# To add this to board, add this to your <product>.mk:
#     $(call inherit-product, device/mediatek/common/utils/utils.mk)

UTILS_PATH := device/mediatek/common/utils

ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_COPY_FILES += \
    $(UTILS_PATH)/init.mediatek.userdebug.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.userdebug.rc
endif

PRODUCT_PACKAGES_DEBUG += \
    stressapptest
