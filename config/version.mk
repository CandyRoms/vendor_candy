# Copyright (C) 2022-2023 CandyRoms
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

ANDROID_VERSION := 14
CANDYVERSION := v14.0

CANDY_BUILD_TYPE ?= UNOFFICIAL
CANDY_MAINTAINER ?= UNKNOWN
CANDY_DATE_YEAR := $(shell date -u +%Y)
CANDY_DATE_MONTH := $(shell date -u +%m)
CANDY_DATE_DAY := $(shell date -u +%d)
CANDY_DATE_HOUR := $(shell date -u +%H)
CANDY_DATE_MINUTE := $(shell date -u +%M)
CANDY_BUILD_DATE := $(CANDY_DATE_YEAR)$(CANDY_DATE_MONTH)$(CANDY_DATE_DAY)-$(CANDY_DATE_HOUR)$(CANDY_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst candy_,,$(CANDY_BUILD))

# OFFICIAL_DEVICES
ifeq ($(CANDY_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/candy/candy.devices)
    ifeq ($(filter $(CANDY_BUILD), $(LIST)), $(CANDY_BUILD))
      IS_OFFICIAL=true
      CANDY_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      CANDY_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(CANDY_BUILD)")
    endif
endif

CANDY_VERSION := $(CANDYVERSION)-$(CANDY_BUILD)-$(CANDY_BUILD_DATE)-VANILLA-$(CANDY_BUILD_TYPE)
ifeq ($(WITH_GAPPS), true)
CANDY_VERSION := $(CANDYVERSION)-$(CANDY_BUILD)-$(CANDY_BUILD_DATE)-GAPPS-$(CANDY_BUILD_TYPE)
endif
CANDY_MOD_VERSION :=$(ANDROID_VERSION)-$(CANDYVERSION)
CANDY_DISPLAY_VERSION := CandyRoms-$(CANDYVERSION)-$(CANDY_BUILD_TYPE)
CANDY_DISPLAY_BUILDTYPE := $(CANDY_BUILD_TYPE)
CANDY_FINGERPRINT := CandyRoms/$(CANDY_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(CANDY_BUILD_DATE)

# CandyRoms System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.candy.version=$(CANDY_DISPLAY_VERSION) \
  ro.candy.build.status=$(CANDY_BUILD_TYPE) \
  ro.modversion=$(CANDY_MOD_VERSION) \
  ro.candy.build.date=$(CANDY_BUILD_DATE) \
  ro.candy.buildtype=$(CANDY_BUILD_TYPE) \
  ro.candy.fingerprint=$(CANDY_FINGERPRINT) \
  ro.candy.device=$(CANDY_BUILD) \
  org.candy.version=$(CANDYVERSION) \
  ro.candy.maintainer=$(CANDY_MAINTAINER)
