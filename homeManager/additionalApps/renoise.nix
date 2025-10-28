{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		renoise.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.renoise.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ renoise ];		
	};	
}
