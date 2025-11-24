{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		systemdBoot.enable = lib.mkOption {
			default = true;	
		};
	};

	config = lib.mkIf config.systemdBoot.enable {
		# Actual content of the module goes here:

		boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;

	};			
}
