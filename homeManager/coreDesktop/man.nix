{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		man.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.man.enable {
		# Actual content of the module goes here:

       	home.packages = with pkgs; [ man ];
		
	};	
}
