{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		firefox.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.firefox.enable {
		# Actual content of the module goes here:

		programs.firefox.enable = true;
				
	};	
}
