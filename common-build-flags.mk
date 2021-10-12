ifndef TARGET_MODE_BL
ifeq ($(TARGET_BUILD_VARIANT), user)
TARGET_MODE_BL := release
else
TARGET_MODE_BL := debug
endif
endif
