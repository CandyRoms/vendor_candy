PRODUCT_BRAND ?= candy

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/candy/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_BOOTANIMATION := vendor/candy/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip
else
PRODUCT_BOOTANIMATION := vendor/candy/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=candy

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
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/candy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/candy/prebuilt/common/bin/50-candy.sh:system/addon.d/50-candy.sh \
    vendor/candy/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/candy/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Candy-specific init file
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.local.rc:root/init.candy.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# superSU
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/SuperSU.zip:system/addon.d/SuperSU.zip \
    vendor/candy/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Candy!
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Required Candy packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt \
    Profiles

# Optional Candy packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Custom Candy packages
PRODUCT_PACKAGES += \
    Launcher3 \
    AudioFX \
    LockClock

# BitSyko Layers
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/app/LayersManager/LayersManager.apk:system/app/LayersManager/LayersManager.apk

# Hide BitSyko Layers Manager app icon from launcher
PRODUCT_PROPERTY_OVERRIDES += \
    ro.layers.noIcon=noIcon

# CM Platform Library
#PRODUCT_PACKAGES += \
#    org.cyanogenmod.platform-res \
#    org.cyanogenmod.platform \
#    org.cyanogenmod.platform.xml

# Candy Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra tools in Candy
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    nano \
    htop \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    pigz

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/common

PRODUCT_VERSION_MAJOR = 6.0.1
PRODUCT_VERSION_MINOR = alpha
PRODUCT_VERSION_MAINTENANCE = 4

# Set CANDY_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef CANDY_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "CANDY_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^CANDY_||g')
        CANDY_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL OFFICIAL,$(CANDY_BUILDTYPE)),)
    CANDY_BUILDTYPE :=
endif

ifdef CANDY_BUILDTYPE
    ifneq ($(CANDY_BUILDTYPE), SNAPSHOT)
        ifdef CANDY_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            CANDY_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := $(shell echo $(CANDY_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := -$(CANDY_EXTRAVERSION)
        endif
    else
        ifndef CANDY_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            CANDY_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := $(shell echo $(CANDY_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := -$(CANDY_EXTRAVERSION)
        endif
    endif
else
    # If CANDY_BUILDTYPE is not defined, set to UNOFFICIAL
    CANDY_BUILDTYPE := UNOFFICIAL
    CANDY_EXTRAVERSION :=
endif

ifeq ($(CANDY_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        CANDY_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif
 
ifeq ($(CANDY_BUILDTYPE), OFFICIAL)
    ifneq ($(TARGET_OFFICIAL_BUILD_ID),)
        CANDY_EXTRAVERSION := OFFICIAL
    endif
endif

ifeq ($(CANDY_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        CANDY_VERSION := CandySiX-$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CANDY_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            CANDY_VERSION := CandySiX-$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(CANDY_BUILD)
        else
            CANDY_VERSION := CandySiX-$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CANDY_BUILD)
        endif
    endif
else
    CANDY_VERSION := CandySiX-$(PRODUCT_VERSION_MINOR)-$(CANDY_BUILD)-$(CANDY_BUILDTYPE)$(CANDY_EXTRAVERSION)-$(shell date -u +%m%d-%H)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.candy.version=$(CANDY_VERSION) \
  ro.candy.releasetype=$(CANDY_BUILDTYPE) \
  ro.modversion=$(CANDY_VERSION) \

CANDY_DISPLAY_VERSION := $(CANDY_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(CANDY_BUILDTYPE), UNOFFICIAL)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(CANDY_EXTRAVERSION),)
        # Remove leading dash from CANDY_EXTRAVERSION
        CANDY_EXTRAVERSION := $(shell echo $(CANDY_EXTRAVERSION) | sed 's/-//')
        TARGET_VENDOR_RELEASE_BUILD_ID := $(CANDY_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    CANDY_DISPLAY_VERSION=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)
  endif
endif
endif

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false


PRODUCT_PROPERTY_OVERRIDES += \
  ro.candy.display.version=$(CANDY_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk

-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
