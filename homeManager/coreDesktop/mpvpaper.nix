{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		mpvpaper.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.mpvpaper.enable {
		# Actual content of the module goes here:

       	home.packages = with pkgs; [ mpvpaper ];
		
	};	
}
