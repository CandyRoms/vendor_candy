# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implies
# See the License for the specific language governing permissions and
# limitations under the License.
#
# WARNING: Everything listed here will be built on ALL platforms,
# including x86, the emulator, and the SDK.  Modules must be uniquely
# named (liblights.panda), and must build everywhere, or limit themselves
# to only building on ARM if they include assembly. Individual makefile
# are responsible for having their own logic, for fine-grained control.
LOCAL_PATH := $(call my-dir)
# if some modules are built directly from this directory (not subdirectories),
# their rules should be written here.
include $(call all-makefiles-under,$(LOCAL_PATH

include $(CLEAR_VARS)
LOCAL_MODULE := PixelLiveWallpaperPrebuiltStatic
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_PRODUCT)/priv-app
LOCAL_SRC_FILES := PixelLiveWallpaperPrebuiltStatic/PixelLiveWallpaperPrebuiltStatic.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
include $(BUILD_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE := WallpaperPickerGoogleRelease
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_PRODUCT)/priv-app
LOCAL_SRC_FILES := WallpaperPickerGoogleRelease.apk/WallpaperPickerGoogleRelease.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
LOCAL_PRIVILEGED_MODULE := true
LOCAL_OVERRIDES_PACKAGES := WallpaperPicker
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
include $(BUILD_PREBUILT)
