# Copyright (C) 2021 CandyRoms
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_pixelgapps := $(INCLUDE_GAPPS)

# Required packages
PRODUCT_PACKAGES += \
    bootanimation.zip \
    CandyWrappers \
    Gallery2 \
    LatinIME \
    Launcher3QuickStep \
    WallpaperPickerGoogleRelease \
    messaging \
    Updater

# Packages to add when GApps are omitted from the build
ifneq ($(include_pixelgapps),true)
PRODUCT_PACKAGES += \
    LivePicker \
    LiveWallpapersPicker
endif

# Pixel Wallpapers
PRODUCT_PACKAGES += \
   PixelThemesStub2019 \
   PixelLiveWallpaperPrebuiltStatic

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
