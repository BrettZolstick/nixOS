{ config, pkgs, lib, osConfig, ... }: 
let 

	#host = config.networking.hostName;

	monitorsByHost = {
		ethanDesktop = [
			"DP-1,		2560x1440@239.97,	1920x0,	1"
			"DP-2,		1920x1080@60.0,		6400x0,	1"
			"DP-3,		1920x1080@60.0,		0x0,	1"
			"HDMI-A-1,	1920x1080@60.0,		4480x0,	1"				
		];
		
		ethanLaptop = [
			"eDP-1,	1920x1080@144,	0x0,	1"
		];
		
		ethanServer = [
			"DP-1,		1920x1080@60.0,	0x0,	1"
		];
		
		cg = [
			"HDMI-A-1,	1920x1080@75.0,		0x0,	1"				
		];
	};

	workspacesByHost = {
		ethanDesktop = [
			"1,	monitor:DP-1,		default:true"
			"2,	monitor:DP-3,		default:true"
			"3,	monitor:HDMI-A-1,	default:true"
			"4,	monitor:DP-2,		default:true"
		];
		
		ethanLaptop = [
			"1,	monitor:eDP-1,	default:true"			
		];
		
		ethanServer = [
			"1, monitor:DP-1, 	defualt:true"
		];
		
		cg = [
			"1, monitor:HDMI-A-1, 	defualt:true"
		];
	};

in
{

	wayland.windowManager.hyprland.settings = {
	
		monitor = monitorsByHost.${osConfig.networking.hostName};
		workspace = workspacesByHost.${osConfig.networking.hostName};

	};
}
