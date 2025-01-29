# Warning: this is actually a product definition, to be inherited from
# To add this to board, add this to your <product>.mk:
#     $(call inherit-product, device/mediatek/utils/utils.mk)

# userdebug rc
ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.mediatek.userdebug.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.mediatek.userdebug.rc
endif

# stress app
PRODUCT_PACKAGES_DEBUG += \
    stressapptest

# GPIO utils
PRODUCT_PACKAGES_DEBUG += gpioinfo gpioget gpioset

# DRM utils
PRODUCT_PACKAGES_DEBUG += modetest
