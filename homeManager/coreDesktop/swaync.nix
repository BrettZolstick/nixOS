{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		swaync.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.swaync.enable {
		# Actual content of the module goes here:
		services.swaync = {
			enable = true;

			
		};

		
	};	
}
