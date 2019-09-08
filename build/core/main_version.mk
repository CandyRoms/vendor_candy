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

ADDITIONAL_BUILD_PROPERTIES += \
    ro.candy.build.version=$(CANDY_BUILD_VERSION) \
    ro.candy.build.date=$(CANDY_DATE) \
    ro.candy.buildtype=$(CANDY_BUILD_TYPE) \
    ro.candy.fingerprint=$(ROM_FINGERPRINT) \
    ro.candy.version=$(CANDY_VERSION) \
    ro.modversion=$(CANDY_VERSION)
