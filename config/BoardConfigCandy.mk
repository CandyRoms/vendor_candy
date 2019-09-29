include vendor/candy/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/candy/config/BoardConfigQcom.mk
endif

include vendor/candy/config/BoardConfigSoong.mk

