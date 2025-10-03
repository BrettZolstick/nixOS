{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		vesktop.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.vesktop.enable {
		# Actual content of the module goes here:
			programs.vesktop.enable = true;
				
	};	
}
