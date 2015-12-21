# Inherit common Candy stuff
$(call inherit-product, vendor/candy/config/common.mk)

# Include Candy audio files
include vendor/candy/config/candy_audio.mk

# Optional Candy packages
PRODUCT_PACKAGES += \
    SoundRecorder
	
# Extra tools in Candy
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip
