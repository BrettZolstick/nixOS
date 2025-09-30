{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	
	options = {
		fish.enable = lib.mkOption {
			type = types.bool;
			default = true;
		};
	};

	config = lib.mkIf config.fish.enable {

		# Actual content of the module goes here:
		
		programs.fish.enable = true;
		
	};
	
}
