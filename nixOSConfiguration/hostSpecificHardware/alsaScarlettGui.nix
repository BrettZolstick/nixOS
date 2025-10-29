{ config, pkgs, lib, ... }: {


	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		alsaScarlettGui.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.alsaScarlettGui.enable {
		# Actual content of the module goes here:
		environment.systemPackages = with pkgs; [ alsa-scarlett-gui ];

	};		
}
