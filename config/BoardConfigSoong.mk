PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE) | sed -e 's|$$|$$$$|g')

# Add variables that we wish to make available to soong here.
ORIG_PATH := $(shell cat $(OUT_DIR)/.path_interposer_origpath)
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_CC \
    KERNEL_CLANG_TRIPLE \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE \
    MAKE_PREBUILT \
    ORIG_PATH

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += candyVarsPlugin

SOONG_CONFIG_candyVarsPlugin :=

define addVar
  SOONG_CONFIG_candyVarsPlugin += $(1)
  SOONG_CONFIG_candyVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))
