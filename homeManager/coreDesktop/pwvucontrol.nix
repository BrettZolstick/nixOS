{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		pwvcontrol.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.pwvcontrol.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ pwvcontrol ];		
	};	
}
