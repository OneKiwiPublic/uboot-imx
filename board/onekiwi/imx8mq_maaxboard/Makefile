#
# Copyright 2017 NXP
#
# SPDX-License-Identifier:      GPL-2.0+
#

obj-y += imx8mq_maaxboard.o

ifdef CONFIG_SPL_BUILD
obj-y += spl.o
obj-y += ddr/helper.o
obj-$(CONFIG_IMX8M_DDR4) += ddr4_timing.o
endif
