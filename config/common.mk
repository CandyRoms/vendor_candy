PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/candy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/candy/prebuilt/common/bin/50-candy.sh:system/addon.d/50-candy.sh

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Candy-specific init file
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.local.rc:root/init.candy.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

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

PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/candy/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/candy/prebuilt/common/bin/sysinit:system/bin/sysinit

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Basic packages
PRODUCT_PACKAGES += \
    Basic \
    BluetoothExt \
    Calculator \
    CandyBootAnimation \
    CandyCane \
    CandyOTA \
    Development \
    LatinIME \
    LiveWallpapersPicker \
    OmniJaws \
    OmniSwitch \
    org.dirtyunicorns.utils \
    PhaseBeam \
    PhotoTable \
    SlimLauncher \
    SlimRecents \
    SnapdragonGallery \
    SpareParts \
    Turbo

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# DU Utils library
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# OMS
PRODUCT_PACKAGES += \
    ThemeInterfacer \
    substratum

ifneq ($(WITH_OPT_APPS),false)
PRODUCT_PACKAGES += \
    K9-Mail \
    SnapdragonMusic \
    TugaBrowser
endif

ifneq ($(WITH_ROOT),false)
PRODUCT_PACKAGES += \
    MagiskManager
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/magisk.zip:system/addon.d/magisk.zip
endif

# Tools
PRODUCT_PACKAGES += \
    e2fsck \
    fsck.exfat \
    mke2fs \
    mkfs.exfat \
    mount.exfat \
    ntfs-3g \
    ntfsfix \
    openvpn \
    tune2fs

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/common

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Default sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.alarm_alert=Helium.ogg \
    ro.config.notification_sound=Argon.ogg \
    ro.config.ringtone=Orion.ogg

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank
endif

# Versioning system
# Candy first version
PRODUCT_VERSION_MAJOR = 7.1.2
PRODUCT_VERSION_MINOR = Stable
PRODUCT_VERSION_MAINTENANCE = v5.2
CANDY_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef CANDY_BUILD_EXTRA
    CANDY_POSTFIX := -$(CANDY_BUILD_EXTRA)
endif

ifndef CANDY_BUILD_TYPE
    CANDY_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
CANDY_VERSION := Candy-$(CANDY_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(CANDY_BUILD_TYPE)$(CANDY_POSTFIX)
CANDY_MOD_VERSION := Candy-$(CANDY_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(CANDY_BUILD_TYPE)$(CANDY_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    candy.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.candy.version=$(CANDY_VERSION) \
    ro.modversion=$(CANDY_MOD_VERSION) \
    ro.candy.buildtype=$(CANDY_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/candy/tools/candy_process_props.py

# Squisher Location
SQUISHER_SCRIPT := vendor/candy/tools/squisher

# Add in some extra optional packages.  In the ROM, this typically will go in
# vendor/extra.
$(call prepend-product-if-exists, vendor/extra/product.mk)
