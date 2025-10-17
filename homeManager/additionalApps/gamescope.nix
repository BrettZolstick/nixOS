{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		gamescope.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.gamescope.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ gamescope ];		
	};	
}
