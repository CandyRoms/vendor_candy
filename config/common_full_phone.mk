# Inherit full common candy stuff
$(call inherit-product, vendor/candy/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include candy LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/candy/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, vendor/candy/config/telephony.mk)
