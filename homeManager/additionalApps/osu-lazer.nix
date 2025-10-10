{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		osu-lazer.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.osu-lazer.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ osu-lazer-bin ];		
	};	
}
