pps-gen-gpio
============

Linux kernel PPS generator using GPIO pins.

In kernel 3.15 there is no support for using a GPIO pin as a PPS generator, only a GPIO PPS client is available. This module derives from the current parallel port PPS generator, adding code to output a PPS signal through a GPIO pin specified in the device tree.

Tests have been run with a Beaglebone Black, and the corresponding modified device tree file is shown. I have used kernel 3.15.3 with a Beaglebone Black where P9 pin 16 (GPIO1_19) is used as PPS output.

Usage
-----
If you use a Beaglebone Black and want to change the PPS output pin, you have to modify your device tree file (am335x-boneblack.dts) accordingly:
- Make sure you have the right pin multiplexing setting:
      	
		pps_gen_pins: pinmux_pps_gen_pins {
			pinctrl-single,pins = <
				0x4C (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a3.gpio1_19 */

Check the [BBB System Reference Manual](https://github.com/CircuitCo/BeagleBone-Black/blob/master/BBB_SRM.pdf?raw=true) and the [am335x Technical Reference Manual](http://www.ti.com/lit/ug/spruh73k/spruh73k.pdf) to find out the correct pinmux table offset of the chosen pin.
- The pps-gen-gpios property defines the pin you want to use as a PPS output:

		pps-gen {
				pinctrl-names = "default";
				pinctrl-0 = <&pps_gen_pins>;
				compatible = "pps-generator-gpios";
				pps-gen-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;

Please note that in order to use the module with any other board using the device tree infrastructure, the following matching definitions are required in the device tree:

		pps-gen               node defined for the PPS GPIO
		pps-generator-gpios   value of ".compatible" property in pps-gen node
		pps-gen-gpios         property in pps-gen node that defines which GPIO pin is used
		
After modifying the device tree, add the files into drivers/pps/generators and configure the driver to be built as module. You need to enable PPS support in the kernel.
