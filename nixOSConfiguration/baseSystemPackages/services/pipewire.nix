{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.

	options = {
		pipewire.enable = lib.mkOption {
			default = true;
		};
	};

	config = lib.mkIf config.pipewire.enable {

		# Actual content of the module goes here:

		services.pipewire.enable = true;

	};
	
}
