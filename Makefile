#
# Makefile for PPS generators.
#

obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
obj-$(CONFIG_PPS_GENERATOR_GPIO) += pps_gen_gpio.o

ifeq ($(CONFIG_PPS_DEBUG),y)
EXTRA_CFLAGS += -DDEBUG
endif
