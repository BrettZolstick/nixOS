{ config, pkgs, lib, home-manager, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		wofi.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.wofi.enable {
		# Actual content of the module goes here:

	       	home.packages = with pkgs; [ wofi ];
		
	};	
}
