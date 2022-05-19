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
