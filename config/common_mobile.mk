# Inherit common mobile candy stuff
$(call inherit-product, vendor/candy/config/common.mk)

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub
