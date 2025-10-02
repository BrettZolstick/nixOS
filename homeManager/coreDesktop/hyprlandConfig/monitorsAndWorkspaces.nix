{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {
		# Monitors
		monitor = [
			"DP-1,		2560x1440@239.97,	1920x0,	1"
			"DP-2,		1920x1080@60.0,		6400x0,	1"
			"DP-3,		1920x1080@60.0,		0x0,	1"
			"HDMI-A-1,	1920x1080@60.0,		4480x0,	1"
		];

		# Workspaces
		workspace = [
			"1,	monitor:DP-1,		default:true"
			"2,	monitor:DP-3,		default:true"
			"3,	monitor:HDMI-A-1,	default:true"
			"4,	monitor:DP-2,		default:true"
		];
		
	};
}
