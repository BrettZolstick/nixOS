{ config, pkgs, lib, ... }: {
	
	# This is wrapped in an option so that it can be easily toggled elsewhere.

	options = {
		alsa-scarlett-gui.enable = lib.mkOption {
			type = types.bool;
			default = true;
		};
	};

	config = lib.mkIf config.alsa-scarlett-gui.enable {

		# Actual content of the module goes here:
	
		environment.systemPackages = [
			alsa-scarlett-gui
		];

	};
	
}
