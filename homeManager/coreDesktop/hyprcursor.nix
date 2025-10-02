{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		hyprcursor.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.hyprcursor.enable {
		# Actual content of the module goes here:
		pointerCursor.hyprcursor.enable = true;
	};	
}
