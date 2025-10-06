{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		yazi.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.yazi.enable {
		# Actual content of the module goes here:

		programs.yazi = {
			enable = true;
		};

	};	
}
