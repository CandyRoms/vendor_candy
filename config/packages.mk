# Required packages
PRODUCT_PACKAGES += \
    bootanimation.zip \
    CandyWrappers \
    Gallery2 \
    LatinIME \
    LivePicker \
    LiveWallpapersPicker \
    Lawnchair \
    messaging \
    Updater

# Tools-Candy
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

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

# Fonts
PRODUCT_PACKAGES += \
    FontArbutusSourceOverlay \
    FontArvoLatoOverlay \
    FontRubikRubikOverlay \
    FontGoogleSansOverlay \

# Cutout control overlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Include Google Sounds for all
PRODUCT_PACKAGES += \
   SoundPickerPrebuilt

# Include Candy theme files
include vendor/candy/themes/backgrounds/themes.mk

# Pixel Wallpapers
PRODUCT_PACKAGES += \
   PixelThemesStub2019 \
   PixelLiveWallpaperPrebuiltStatic
