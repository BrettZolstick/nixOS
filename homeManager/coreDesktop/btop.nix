{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		btop.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.btop.enable {
		# Actual content of the module goes here:
		
		programs.btop.enable = true;		
		
	};	
}
