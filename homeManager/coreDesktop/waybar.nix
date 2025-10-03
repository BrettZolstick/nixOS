{ config, pkgs, lib, stylix, ... }: 

let 
	hardwareMonitor = pkgs.writeShellScriptBin "hardware-monitor" '' 
		#!/bin/bash
		
		cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
		ram=$(free -h | awk '/Mem:/ {print $3}')
		gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)

		
		
		echo "󰍛 ''${cpu}% |   ''${ram}B | 󰢮  ''${gpu}% ''${null}"
	'';

	colors = config.lib.stylix.colors.withHashtag;
	withAlpha = color: alphaHex: "${color}${alphaHex}";
	hexWithAlpha = color: opacity: config.lib.stylix.mkOpacityHexColor "${color}${opacity}";
in
{

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		waybar.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.waybar.enable {
		# Actual content of the module goes here:

		home.packages = [ hardwareMonitor ];

		# disable stylix auto themeing
		stylix.targets.waybar.enable = true;
		
		programs.waybar = {
			enable = true;
			systemd.enable = true;

			settings = [{
				layer = "top";
				position = "top";
				modules-left = [ "hyprland/workspaces" "hyprland/window" ];
				modules-center = [ "custom/hardwareMonitor" ];
				modules-right = [ "tray" "custom/updates" "custom/clipboard" "network" "pulseaudio" "clock" ];
				"hyprland/workspaces" = {
					all-outputs = true;
					disable-scroll = true;
					format = "{}";
					on-click = "activate";
				};
				"custom/hardwareMonitor" = {
					exec = "${hardwareMonitor}/bin/hardware-monitor";
					interval = 1;
					return-type = "text";
					format = "{}";
					on-click = "kitty -e btop";
					tooltip = false;
				};
				"clock" = {
					format = "{:%a %m.%d.%Y %I:%M %p}";
					tooltip = false;
				};
				"network" = {
					format-ethernet = "󰈀  {ifname}";
					format-wifi = "  {essid} ({signalStrength}%)";
					format-disconnected = "󱘖  Disconnected";
				};
				"pulseaudio" = {
					format = "  {volume}%";
					on-click = "pavucontrol";
				};
			}];
			
			style = ''
				
				/* ------------ Waybar Global ------------ */
				* {
				    font-family: "JetBrainsMono Nerd Font", "Noto Sans", sans-serif;
				    font-size: 13px;
				}
				
				/* ------------ Background ------------ */
				window#waybar {
				    background: rgba(0,0,0,0);
				}
				
				
				/* ------------ Workspaces ------------ */
				#workspaces {
					margin: 4px 2px;
					padding: 0px 4px;
				}
				#workspaces button{ /* The individual workspace identifers */
					background: alpha(${colors.base02},0.1);
					margin: 0px 1px;
					padding: 0px 3px; 
					border-radius: 4px;
					font-weight: lighter; 
				}
				#workspaces button.visible{ /* All workspaces visible on screen*/
					font-weight: bold;
				}
				#workspaces button.active{ /* The current active workspace*/
					background: rgba(200,200,200,0.8);
					color: rgba(20,20,20,1);
					font-weight: bold;
				}
				
				
				
				/* ------------ Active Window Title ------------ */
				#window {
					background: rgba(0,0,0,0.2);
					border-radius: 5px;
					margin: 6px 2px;
					padding: 0px 8px;
					
				}
				
				
				
				/* ------------ Hardware Monitor ------------ */
				#custom-hardwareMonitor {
					background: rgba(0,0,0,0.3);
					margin: 6px; 
					padding: 0px 8px;
					border-radius: 5px;
				}
				
				/* ------------ System Tray ------------ */
				#tray {
					background: rgba(0,0,0,0.4);
					margin: 4px; 
					padding: 0px 8px;
					border-radius: 500px;
				}
				
				/* ------------ Right Modules ------------ */
				#network,
				#pulseaudio,
				#custom-updates,
				#clock {
					background: rgba(20,20,20,0.7);
					color: rgba(200,200,200,1);
					font-weight: bold;
					margin: 2px 2px; 
					padding: 0px 8px;
					border-radius: 5px;
				}
				
				#custom-updates{
					padding-right: 11px;
				}
				
				/* ------------ Network Disconnected ------------ */
				#network.disconnected{
					background: rgba(200,40,40,0.7);
					color: rgba(255,255,255,1);
					font-weight: 800; 
				}
				
			'';	
		};	
	};	
}
