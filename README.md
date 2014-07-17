pps-gen-gpio
============

Linux kernel PPS generator using GPIO pins.

In kernel 3.15 there is no support for using a GPIO pin as a PPS generator, only a GPIO PPS client is available. This module derives from the current parallel port PPS generator, adding code to output a PPS signal through a GPIO pin specified in the device tree.

Tests have been run with a Beaglebone Black, and the corresponding modified device tree file is shown. I have used kernel 3.15.3 with a Beaglebone Black where P9 pin 16 (GPIO1_19) is used as PPS output. You need to enable PPS support in the kernel.
