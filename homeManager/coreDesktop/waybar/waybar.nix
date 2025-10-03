{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		waybar.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.waybar.enable {
		# Actual content of the module goes here:
		programs.waybar = {
			enable = true;
			systemd.enable = true;
			# settings = [{
			# 	layer = "top";
			# 	position = "top";
			# 	modules-left = [ "hyprland/workspaces" "hyprland/window" ];
			# 	#modules-center = [ "custom/hardwareMonitor" ];
			# 	modules-right = [ "tray" "custom/updates" "custom/clipboard" "network" "pulseaudio" "clock" ];
			# 	#"hyprland/workspaces" = {
			# 	#	all-outputs = true;
			# 	#	disable-scroll = true;
			# 	#	format = "{}";
			# 	#	on-click = "activate";
			# 	#};
			# 	#"custom/hardwareMonitor" = {
			# 	#	exec = "bash ./scripts/hardwareMonitor.sh";
			# 	#	interval = 1;
			# 	#	return-type = "text";
			# 	#	format = "{}";
			# 	#	on-click = "kitty -e btop";
			# 	#	tooltip = false;
			# 	#};
			# }];	
		};
		
	};	
}
