{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		hyprpaper.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.hyprpaper.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ hyprpaper ];		
	};	
}
