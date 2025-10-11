{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		epr.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.epr.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ epr ];		
	};	
}
