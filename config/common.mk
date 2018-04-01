# Copyright (C) 2018 CandyRoms
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Google property overides
PRODUCT_GENERIC_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# LatinIME gesture typing
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/candy/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/candy/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/candy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/candy/prebuilt/common/bin/50-candy.sh:system/addon.d/50-candy.sh \
    vendor/candy/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Candy-specific init file
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.local.rc:root/init.candy.rc

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/candy/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Candy-specific startup services
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/candy/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/candy/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/candy/prebuilt/bin/clean_cache.sh:system/bin/clean_cache.sh

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    WeatherClient

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Weather client
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/permissions/com.android.providers.weather.xml:system/etc/permissions/com.android.providers.weather.xml \
    vendor/candy/prebuilt/common/etc/default-permissions/com.android.providers.weather.xml:system/etc/default-permissions/com.android.providers.weather.xml

# Prebuilt packages
PRODUCT_PACKAGES += \
    nexuslauncher \
    pixelbridge

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    bootanimation.zip \
    CandyWrappers \
    LatinIME \
    BluetoothExt

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

PRODUCT_PACKAGES += \
    charger_res_images

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/common

# Versioning System
# candy first version.
PRODUCT_VERSION_MAJOR = 9
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0
CANDY_POSTFIX := -$(shell date +"%Y%m%d-%H%M")

ifdef CANDY_BUILD_EXTRA
    CANDY_POSTFIX += -$(CANDY_BUILD_EXTRA)
endif

# Set the default version to unofficial
ifndef CANDY_BUILD_TYPE
    CANDY_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
CANDY_VERSION := Candy-$(CANDY_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(CANDY_BUILD_TYPE)$(CANDY_POSTFIX)
CANDY_MOD_VERSION := Candy-$(CANDY_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(CANDY_BUILD_TYPE)$(CANDY_POSTFIX)

PRODUCT_VERSION:= $(TARGET_PRODUCT)
PRODUCT_VERSION := $(subst candy_,,$(PRODUCT_VERSION))

ROM_FINGERPRINT := Candy/$(PLATFORM_VERSION)/$(PRODUCT_VERSION)/$(shell date +%Y%m%d.%H:%M)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    candy.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.candy.version=$(CANDY_VERSION) \
    ro.modversion=$(CANDY_VERSION) \
    ro.candy.buildtype=$(CANDY_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.candy.fingerprint=$(ROM_FINGERPRINT)

# Google sounds
include vendor/candy/google/GoogleAudio.mk

EXTENDED_POST_PROCESS_PROPS := vendor/candy/tools/candy_process_props.py

# Unlimited photo storage in Google Photos
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/etc/sysconfig/pixel_2017_exclusive.xml:system/etc/sysconfig/pixel_2017_exclusive.xml

# Accents and themes
include vendor/candy/themes/accents.mk
include vendor/candy/themes/themes.mk

# CustomDoze for all devices
PRODUCT_PACKAGES += \
    CustomDoze

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock

# Fonts packages
PRODUCT_PACKAGES += \
    candy-fonts

$(call inherit-product-if-exists, vendor/extra/product.mk)
