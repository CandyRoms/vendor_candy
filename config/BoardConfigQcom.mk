include vendor/candy/config/BoardConfigQcomDefs.mk

BOARD_USES_ADRENO := true

# UM platforms no longer need this set on O+
ifneq ($(filter $(B_FAMILY) $(B64_FAMILY) $(BR_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_USES_QCOM_BSP := true
endif

# Tell HALs that we're compiling an AOSP build with an in-line kernel
TARGET_COMPILE_WITH_MSM_KERNEL := true

ifneq ($(filter msm7x27a msm7x30 msm8660 msm8960,$(TARGET_BOARD_PLATFORM)),)
    TARGET_USES_QCOM_BSP_LEGACY := true
    # Enable legacy audio functions
    ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
        USE_CUSTOM_AUDIO_POLICY := 1
    endif
endif

ifneq ($(TARGET_USES_PREBUILT_CAMERA_SERVICE), true)
PRODUCT_SOONG_NAMESPACES += \
    frameworks/av/camera/cameraserver \
    frameworks/av/services/camera/libcameraservice
endif

# Enable media extensions
TARGET_USES_MEDIA_EXTENSIONS := true

# Allow building audio encoders
TARGET_USES_QCOM_MM_AUDIO := true

# Enable color metadata for every UM platform
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
    TARGET_USES_COLOR_METADATA := true
endif

# Enable DRM PP driver on UM platforms that support it
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_USES_DRM_PP := true
endif

# Mark GRALLOC_USAGE_HW_2D, GRALLOC_USAGE_EXTERNAL_DISP and GRALLOC_USAGE_PRIVATE_WFD as valid gralloc bits
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 10)
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 13)
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 21)

# Mark GRALLOC_USAGE_PRIVATE_HEIF_VIDEO as valid gralloc bits on UM platforms that support it
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 27)
endif

PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)

ifneq ($(TARGET_USE_AOSP_SURFACEFLINGER), true)
    # Required for frameworks/native
    ifeq ($(QCOM_HARDWARE_VARIANT),msm8996)
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_3_18_FAMILY := true
    else ifeq ($(QCOM_HARDWARE_VARIANT),msm8998)
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_4_4_FAMILY := true
    else ifeq ($(QCOM_HARDWARE_VARIANT),sdm845)
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_4_9_FAMILY := true
    else ifeq ($(QCOM_HARDWARE_VARIANT),sm8150)
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_4_14_FAMILY := true
    endif
endif
