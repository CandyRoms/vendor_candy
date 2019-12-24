# Required packages
PRODUCT_PACKAGES += \
    bootanimation.zip \
    Gallery2 \
    LatinIME \
    Launcher3 \
    LiveWallpapers \
    LiveWallpapersPicker \
    messaging \
    ThemePicker \
    Updater

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Device Personalization Services
PRODUCT_PACKAGES += MatchmakerPrebuilt

# Fonts
PRODUCT_PACKAGES += \
    FontArbutusSourceOverlay \
    FontArvoLatoOverlay \
    FontRubikRubikOverlay \
    FontGoogleSansOverlay \

-include vendor/candy/config/overlay.mk

# Include PixelGApps in build
ifneq ($(TARGET_BUILD_PIXELGAPPS), )
$(call inherit-product-if-exists, vendor/pixelgapps/pixel-gapps.mk)
endif
