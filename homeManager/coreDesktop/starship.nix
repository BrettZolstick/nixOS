{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		starship.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.starship.enable {
		# Actual content of the module goes here:

		programs.starship = {
			enable = true;
			enableFishIntegration = true;
			};
		};
		
	};	
}
