##########################################################
## define common variables, like TA_DEV_KIT_DIR         ##
##########################################################
TOP_ROOT_ABS := $(realpath $(TOP))

HOST_MAKE := prebuilts/build-tools/linux-x86/bin/make
COMPILE_LINE := $(HOST_MAKE)

# OPTEE_OUT_DIR could be exported explicitly
# if PRODUCT_OUT is not the default out directory in aosp workspace
OPTEE_OUT_DIR ?= $(PRODUCT_OUT)/optee
ABS_OPTEE_OUT_DIR ?= $(realpath $(PRODUCT_OUT))/optee
OPTEE_TA_OUT_DIR ?= $(OPTEE_OUT_DIR)/ta
ABS_OPTEE_TA_OUT_DIR ?= $(ABS_OPTEE_OUT_DIR)/ta

# Set so that OP-TEE clients can find the installed dev-kit, which
# depends on platform and its OP-TEE word-size.
OPTEE_OS_OUT_DIR ?= $(OPTEE_OUT_DIR)/arm-plat-$(OPTEE_PLATFORM)
ABS_OPTEE_OS_OUT_DIR := $(ABS_OPTEE_OUT_DIR)/arm-plat-$(OPTEE_PLATFORM)
TA_DEV_KIT_DIR := $(ABS_OPTEE_OS_OUT_DIR)/export-${OPTEE_TA_TARGETS}

# Set android cross compiler
ifdef OPTEE_LINARO_CROSS_COMPILE64
CROSS_COMPILE64 := $(TOP_ROOT_ABS)/$(OPTEE_LINARO_CROSS_COMPILE64)
else
# clang as default on Android
CROSS_COMPILE64 := aarch64-android
CLANG_PATH := $(TOP_ROOT_ABS)/$(LLVM_PREBUILTS_BASE)/$(BUILD_OS)-x86/$(LLVM_PREBUILTS_VERSION)/bin
COMPILE_LINE := PATH=$(CLANG_PATH):$$PATH $(COMPILE_LINE) COMPILER=clang
endif

# Set PYTHONPATH
ifdef OPTEE_PYTHONPATH
COMPILE_LINE := PYTHONPATH=$(TOP_ROOT_ABS)/$(OPTEE_PYTHONPATH) $(COMPILE_LINE)
endif

# OP-TEE binary
OPTEE_BIN := $(OPTEE_OS_OUT_DIR)/core/tee.bin
$(OPTEE_BIN) : $(sort $(shell find -L $(OPTEE_OS_DIR)))

###########################################################
## define making rules for $(OPTEE_BIN) target, and add  ##
## condition check to make it only be defined once       ##
## even though this mk file might be included multiple   ##
## times. The process to generate $(OPTEE_BIN) file will ##
## generate the header files under                       ##
## $(TA_DEV_KIT_DIR)/host_include too.                   ##
## And the $(OPTEE_BIN) will be used as dependency for   ##
## other projects                                        ##
###########################################################
ifneq (true,$(BUILD_OPTEE_OS_DEFINED))
BUILD_OPTEE_OS_DEFINED := true
$(OPTEE_BIN):
	@echo "Start building optee_os..."
	$(COMPILE_LINE) \
		CROSS_COMPILE64=$(CROSS_COMPILE64) \
		-C $(TOP_ROOT_ABS)/$(OPTEE_OS_DIR) \
		O=$(ABS_OPTEE_OS_OUT_DIR) \
		CFG_USER_TA_TARGETS=$(OPTEE_TA_TARGETS) \
		CFG_ARM64_core=$(OPTEE_CFG_ARM64_CORE) \
		CFG_DRAM_SIZE=$(OPTEE_CFG_DRAM_SIZE) \
		PLATFORM=$(OPTEE_PLATFORM) \
		PLATFORM_FLAVOR=$(OPTEE_PLATFORM_FLAVOR) \
		$(OPTEE_EXTRA_FLAGS)
	@echo "Finished building optee_os..."

endif

##########################################################
## Lines for building TAs automatically                 ##
## will only be included in Android.mk for TAs          ##
## local_module:                                        ##
##     need to be defined before include for this       ##
##########################################################
ifneq (false,$(INCLUDE_FOR_BUILD_TA))
include $(CLEAR_VARS)

LOCAL_MODULE := $(local_module)
LOCAL_PREBUILT_MODULE_FILE := $(OPTEE_TA_OUT_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/optee_armtz
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional

TA_TMP_DIR := $(subst /,_,$(LOCAL_PATH))
TA_TMP_FILE := $(OPTEE_TA_OUT_DIR)/$(TA_TMP_DIR)/$(LOCAL_MODULE)
$(LOCAL_PREBUILT_MODULE_FILE): $(TA_TMP_FILE)
	@mkdir -p $(dir $@)
	cp -vf $< $@

TA_TMP_FILE_DEPS :=
ifneq ($(local_module_deps), )
$(foreach dep,$(local_module_deps), $(eval TA_TMP_FILE_DEPS += $(TARGET_OUT_VENDOR)/lib/optee_armtz/$(dep)))
endif
$(TA_TMP_FILE): $(TA_TMP_FILE_DEPS)
$(TA_TMP_FILE): PRIVATE_TA_SRC_DIR := $(LOCAL_PATH)
$(TA_TMP_FILE): PRIVATE_TA_TMP_FILE := $(TA_TMP_FILE)
$(TA_TMP_FILE): PRIVATE_TA_TMP_DIR := $(TA_TMP_DIR)
$(TA_TMP_FILE): $(OPTEE_BIN)
	@echo "Start building TA for $(PRIVATE_TA_SRC_DIR) $(PRIVATE_TA_TMP_FILE)..."
	$(COMPILE_LINE) \
		CROSS_COMPILE64=$(CROSS_COMPILE64) \
		-C $(TOP_ROOT_ABS)/$(PRIVATE_TA_SRC_DIR) \
		O=$(ABS_OPTEE_TA_OUT_DIR)/$(PRIVATE_TA_TMP_DIR) \
		TA_DEV_KIT_DIR=$(TA_DEV_KIT_DIR)
	@echo "Finished building TA for $(PRIVATE_TA_SRC_DIR) $(PRIVATE_TA_TMP_FILE)..."

include $(BUILD_PREBUILT)
local_module_deps :=
endif
