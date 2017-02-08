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

# candy-specific init file
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

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    CandyCane \
    LockClock

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam \
    Chromium \
    Snap

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    LatinIME \
    BluetoothExt \
    CandyBootAnimation \
    CandyOTA \
    masquerade \
    Eleven \
    OmniSwitch \
    Calculator  
    
# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# DU Utils Library
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

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

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# SU and root apps
ifneq ($(WITH_SU),false)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

# Versioning System
# Candy first version.
PRODUCT_VERSION_MAJOR = 7.1.1
PRODUCT_VERSION_MINOR = Beta
PRODUCT_VERSION_MAINTENANCE = v2.5
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
