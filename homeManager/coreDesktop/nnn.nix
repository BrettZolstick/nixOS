{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		nnn.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.nnn.enable {
		# Actual content of the module goes here:

		programs.nnn.enable = true;
		
		
	};	
}
