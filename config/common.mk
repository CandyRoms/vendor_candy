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
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
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
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    persist.sys.disable_rescue=true

# Set custom volume steps
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    keyguard.no_require_sim=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/candy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/candy/prebuilt/common/bin/50-candy.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-candy.sh \
    vendor/candy/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

# Backup stuff
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/candy/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/candy/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Candy fonts
PRODUCT_PACKAGES += \
    candy-fonts

# Copy all Candy-specific init rc files
$(foreach f,$(wildcard vendor/candy/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Common prebuilt permissions
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/sysctl.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/sysctl.conf \
    vendor/candy/prebuilt/common/etc/permissions/privapp-permissions-candy-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-candy.xml \
    vendor/candy/prebuilt/common/etc/permissions/privapp-permissions-candy-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-candy.xml \
    vendor/candy/prebuilt/common/etc/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google.xml \
    vendor/candy/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/candy/prebuilt/common/etc/permissions/com.android.providers.weather.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.android.providers.weather.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Sysconfigs
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/sysconfig/candy-power-whitelist.xml:system/etc/sysconfig/candy-power-whitelist.xml \
    vendor/candy/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/candy/prebuilt/common/etc/sysconfig/backup.xml:system/etc/sysconfig/backup.xml

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Charger images
PRODUCT_PACKAGES += \
    charger_res_images

# whitelist packages for location providers not in system
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.services.whitelist.packagelist=com.google.android.gms

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.storage_manager.enabled=true

# GSans font
include vendor/candy/config/fonts.mk

# Packages
include vendor/candy/config/packages.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/common

# Google sounds
include vendor/candy/google/GoogleAudio.mk

# easy way to extend to add more packages
$(call inherit-product-if-exists, vendor/extra/product.mk)
