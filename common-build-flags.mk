ifndef TARGET_MODE_BL
ifeq ($(TARGET_BUILD_VARIANT), user)
ifeq ($(FACTORY_BUILD), true)
TARGET_MODE_BL := factory
else
TARGET_MODE_BL := release
endif
else
TARGET_MODE_BL := debug
endif
endif

define copy_bl_binaries
$(eval PRODUCT_COPY_FILES += \
           $(1)/bl2-$(TARGET_MODE_BL).img:$(TARGET_OUT)/bl2.img \
           $(1)/fip-$(TARGET_MODE_BL).bin:$(TARGET_OUT)/fip.bin \
           $(1)/lk-$(TARGET_MODE_BL).bin:$(TARGET_OUT)/lk.bin \
           $(1)/u-boot-initial-$(TARGET_MODE_BL)-env:$(TARGET_OUT)/u-boot-initial-env) \
$(if $(filter factory,$(TARGET_MODE_BL)),\
  $(eval PRODUCT_COPY_FILES += \
             $(1)/auth_sv5.auth:$(TARGET_OUT)/auth_sv5.auth \
             $(1)/lk-$(TARGET_MODE_BL).sign:$(TARGET_OUT)/lk.sign))
endef
