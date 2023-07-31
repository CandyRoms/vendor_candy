# Inherit common mobile candy stuff
$(call inherit-product, vendor/candy/config/common.mk)

# Include AOSP audio files
include vendor/candy/config/aosp_audio.mk

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub
