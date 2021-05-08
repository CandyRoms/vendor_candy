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
$(call inherit-product-if-exists, vendor/google/customization/config.mk)

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
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    keyguard.no_require_sim=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_SYSTEM_DEFAULT_PROPERTIES  += \
    dalvik.vm.debug.alloc=0

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/candy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/candy/prebuilt/common/bin/50-candy.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-candy.sh

# AB backup tool
ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/candy/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/candy/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Backup GApps if not inlined
ifeq ($(INCLUDE_GAPPS),)
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/addon.d/69-gapps.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/69-gapps.sh
endif

# Backup GApps if not inlined
ifeq ($(INCLUDE_GAPPS),)
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/addon.d/69-gapps.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/69-gapps.sh
endif

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh


# Copy all Candy-specific init rc files
$(foreach f,$(wildcard vendor/candy/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Common prebuilt permissions
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/sysctl.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/sysctl.conf \
    vendor/candy/prebuilt/common/etc/permissions/com.android.providers.weather.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.android.providers.weather.xml \
    vendor/candy/prebuilt/common/etc/permissions/privapp-permissions-candy-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-candy-product.xml \
    vendor/candy/prebuilt/common/etc/permissions/privapp-permissions-candy-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-candy-system_ext.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/sysconfig/candy-power-whitelist.xml:system/etc/sysconfig/candy-power-whitelist.xml \
    vendor/candy/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/candy/prebuilt/common/etc/sysconfig/backup.xml:system/etc/sysconfig/backup.xml

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

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


DEVICE_PACKAGE_OVERLAYS += vendor/candy/overlay/common

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/candy/overlay/common \

# Google sounds
include vendor/candy/google/GoogleAudio.mk

# Gapps
ifeq ($(INCLUDE_GAPPS),true)
$(call inherit-product-if-exists, vendor/gapps/config.mk)
endif

# easy way to extend to add more packages
$(call inherit-product-if-exists, vendor/extra/product.mk)
