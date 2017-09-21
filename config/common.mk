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

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml \
    vendor/candy/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/candy/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/candy/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Candy-specific init file
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.local.rc:root/init.local.rc \
    vendor/candy/prebuilt/common/etc/init.candy.rc:root/init.candy.rc

# Candy fonts
PRODUCT_PACKAGES += \
    candy-fonts

# Copy all Candy-specific init rc files
$(foreach f,$(wildcard vendor/candy/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/sysctl.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/sysctl.conf \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml \
    vendor/candy/config/permissions/privapp-permissions-candy-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-candy.xml \
    vendor/candy/config/permissions/privapp-permissions-candy-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-candy.xml \
    vendor/candy/config/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google.xml \
    vendor/candy/config/permissions/privapp-permissions-google-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/candy-power-whitelist.xml:system/etc/sysconfig/candy-power-whitelist.xml

# Weather client
#PRODUCT_COPY_FILES += \
#    vendor/candy/prebuilt/common/etc/permissions/com.android.providers.weather.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.android.providers.weather.xml \
#    vendor/candy/prebuilt/common/etc/default-permissions/com.android.providers.weather.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/com.android.providers.weather.xml

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false
# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_PACKAGES += \
    charger_res_images

# whitelist packages for location providers not in system
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.services.whitelist.packagelist=com.google.android.gms

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

# GSans font
include vendor/candy/config/fonts.mk

# Packages
include vendor/candy/config/packages.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/common

# Google sounds
include vendor/candy/google/GoogleAudio.mk

$(call inherit-product-if-exists, vendor/extra/product.mk)
