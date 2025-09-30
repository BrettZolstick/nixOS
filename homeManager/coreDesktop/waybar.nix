{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		waybar.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.waybar.enable {
		# Actual content of the module goes here:

		programs.waybar.enable = true;
				
	};	
}
