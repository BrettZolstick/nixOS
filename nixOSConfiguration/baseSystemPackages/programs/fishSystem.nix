{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.	
	options = {
		fishSystem.enable = lib.mkOption {
			default = true;	
		};
	};

	config = lib.mkIf config.fishSystem.enable {
		# Actual content of the module goes here:

		programs.fish.enable = true;
		
	};
	
}
