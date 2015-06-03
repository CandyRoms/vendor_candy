# Inherit common Candy stuff
$(call inherit-product, vendor/candy/config/common_full.mk)

# Required Candy packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Candy LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/dictionaries

# Include Candy audio files
include vendor/candy/config/candy_audio.mk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/candy/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif 
