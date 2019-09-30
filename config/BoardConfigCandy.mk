include vendor/candy/config/BoardConfigKernel.mk

# QCOM HW crypto
ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
    TARGET_CRYPTFS_HW_PATH ?= vendor/qcom/opensource/cryptfs_hw
endif

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/candy/config/BoardConfigQcom.mk
endif

include vendor/candy/config/BoardConfigSoong.mk
