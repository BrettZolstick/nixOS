{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.

	# hyprland is enabled at system level because if it's only enabled at 
	# user level, it will not show up in display managers

	options = {
		hyprlandSystem.enable = lib.mkOption {
			default = true;
		};
	};

	config = lib.mkIf config.hyprlandSystem.enable {

		# Actual content of the module goes here:

		programs.hyprland.enable = true;

	};
	
}
