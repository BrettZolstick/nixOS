{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		AMDGraphics.enable = lib.mkOption {
			default = true;	
		};
	};

	config = lib.mkIf config.AMDGraphics.enable {
		# Actual content of the module goes here:

		hardware.graphics = {
			enable = true;
			enable32Bit = true;	
		};

	};			
}
