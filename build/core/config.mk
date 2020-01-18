# Copyright (C) 2019 CandyRoms
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

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
SELINUX_IGNORE_NEVERALLOWS := true
endif

BUILD_RRO_SYSTEM_PACKAGE := $(TOP)/vendor/candy/build/core/system_rro.mk

# Include board/platform macros
include vendor/candy/build/core/utils.mk

# Include vendor platform definitions
include vendor/candy/build/core/vendor/*.mk

# Rules for QCOM targets
include $(TOPDIR)vendor/candy/build/core/qcom_target.mk

# Filter out duplicates
define uniq
$(if $1,$(firstword $1) $(call uniq,$(filter-out $(firstword $1),$1)))
endef

#define uniq__dx
#  $(eval seen :=)
#  $(foreach _,$1,$(if $(filter $_,${seen}),,$(eval seen += $_)))
#  ${seen}
#endef

#PRODUCT_BOOT_JARS := $(call uniq__dx,$(subst $(space), ,$(strip $(PRODUCT_BOOT_JARS))))
