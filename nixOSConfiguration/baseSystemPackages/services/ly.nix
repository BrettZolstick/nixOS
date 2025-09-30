{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		ly.enable = lib.mkOption {
			default = true;
		};
	};

	config = lib.mkIf config.ly.enable {
		# Actual content of the module goes here:

		services.displayManager.ly.enable = true;
		
	};
	
}
