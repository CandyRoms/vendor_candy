# Copyright (C) 2020 CandyRoms
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

# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# This file is -included from vendor/candy/build/core/main.mk

# Versioning System
# candy first version.
PRODUCT_VERSION_MAJOR = 11
PRODUCT_VERSION_MINOR = Alpha
CANDY_DATE := $(shell date +"%Y%m%d-%H%M")
GAPPS_FLAG :=

ifdef CANDY_BUILD_EXTRA
    CANDY_POSTFIX += $(CANDY_BUILD_EXTRA)
endif

# Set the default version to unofficial
ifndef CANDY_BUILD_TYPE
    CANDY_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(INCLUDE_GAPPS),true)
    GAPPS_FLAG := _GAPPS
endif

# Set all versions
CANDY_BUILD_VERSION := $(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_MINOR)
CANDY_VERSION := Candy-$(CANDY_BUILD)-$(CANDY_BUILD_VERSION)-$(CANDY_BUILD_TYPE)$(GAPPS_FLAG)-$(CANDY_DATE)
CANDY_MOD_VERSION := Candy-$(CANDY_BUILD)-$(CANDY_BUILD_VERSION)-$(CANDY_BUILD_TYPE)$(GAPPS_FLAG)-$(CANDY_DATE)

PRODUCT_VERSION := $(TARGET_PRODUCT)
PRODUCT_VERSION := $(subst candy_,,$(PRODUCT_VERSION))

ROM_FINGERPRINT := Candy/$(PLATFORM_VERSION)/$(PRODUCT_VERSION)/$(shell date -u +%H%M)

ADDITIONAL_BUILD_PROPERTIES += \
    ro.candy.build.version=$(CANDY_BUILD_VERSION) \
    ro.candy.build.date=$(CANDY_DATE) \
    ro.candy.buildtype=$(CANDY_BUILD_TYPE)$(GAPPS_FLAG) \
    ro.candy.fingerprint=$(ROM_FINGERPRINT) \
    ro.candy.backuptool.version=$(PRODUCT_VERSION_MAJOR) \
    ro.candy.version=$(CANDY_VERSION) \
    ro.modversion=$(CANDY_VERSION)
