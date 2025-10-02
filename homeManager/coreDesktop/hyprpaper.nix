{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		hyprpaper.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.hyprpaper.enable {
		# Actual content of the module goes here:
		services.hyprpaper.enable = true;

		# this is to fix the hyprpaper service not starting because it tries to start before wayland
		systemd.user.services.hyprpaper = {
			Unit = {
		      After = [ "hyprland-session.target" ];
		      PartOf = [ "hyprland-session.target" ];
		    };
		    Install = {
		      WantedBy = [ "hyprland-session.target" ];
		    };
		};
		
	};	
}
