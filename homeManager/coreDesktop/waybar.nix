{ config, pkgs, lib, stylix, ... }: 

let 
	hardwareMonitor = pkgs.writeShellScriptBin "hardware-monitor" '' 
		#!/bin/bash
		
		cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
		ram=$(free -h | awk '/Mem:/ {print $3}')
		gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)

		
		
		echo "󰍛 ''${cpu}% |   ''${ram}B | 󰢮  ''${gpu}% ''${null}"
	'';

	remoteRepoStatus = pkgs.writeShellScriptBin "remoteRepoStatus" ''
		#!/usr/bin/env bash
		set -euo pipefail

		# Config via env (defaults shown)
		REPO="${REPO:-$PWD}"
		REMOTE="${REMOTE:-origin}"
		BRANCH="${BRANCH:-main}"
		FETCH_TIMEOUT="${FETCH_TIMEOUT:-3s}"   # set to 0s to effectively skip fetch

		GIT="git -C \"$REPO\""
		remote_ref="$REMOTE/$BRANCH"

		# Not a repo? -> false
		if ! eval $GIT rev-parse --git-dir >/dev/null 2>&1; then
		  echo false
		  exit 0
		fi

		# Best-effort fetch (non-fatal if offline)
		timeout "$FETCH_TIMEOUT" bash -lc "$GIT fetch --quiet \"$REMOTE\" \"$BRANCH\"" >/dev/null 2>&1 || true

		# If we still don't have the remote ref locally, call it not behind
		if ! eval $GIT show-ref --verify --quiet "refs/remotes/$remote_ref"; then
		  echo false
		  exit 0
		fi

		# ahead/behind counts: left=HEAD, right=remote
		read -r ahead behind < <(eval $GIT rev-list --left-right --count HEAD...\"$remote_ref\" 2>/dev/null | awk '{print $1, $2}')

		# Print true only if behind > 0
		if [[ "${behind:-0}" -gt 0 ]]; then
		  echo true
		else
		  echo false
		fi
	'';
	

	colors = config.lib.stylix.colors.withHashtag;
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
		stylix.targets.waybar.enable = false;
		
		programs.waybar = {
			enable = true;
			systemd.enable = true;
			systemd.target = "hyprland-session.target";

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
					on-click = "pwvucontrol";
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
				    background: alpha(${colors.base00}, 0);
				}
				
				
				/* ------------ Workspaces ------------ */
				#workspaces {
					margin: 4px 2px;
					padding: 0px 4px;
				}
				#workspaces button{ /* The individual workspace identifers */
					background: alpha(${colors.base01},0.6);
					color: alpha(${colors.base05},0.8);
					margin: 0px 1px;
					padding: 0px 3px; 
					border-radius: 4px;
					font-weight: normal; 
				}
				#workspaces button.visible{ /* All workspaces visible on screen*/
					background: alpha(${colors.base01},0.8);
					color: alpha(${colors.base06},0.9);
					font-weight: bold;
				}
				#workspaces button.active{ /* The current active workspace*/
					background: alpha(${colors.base01},1.0);
					color: alpha(${colors.base06},0.9);
					font-weight: bold;
				}
				
				
				
				/* ------------ Active Window Title ------------ */
				#window {
					background: alpha(${colors.base00},0.8);
					color: alpha(${colors.base06},0.9);
					border-radius: 5px;
					margin: 6px 2px;
					padding: 0px 8px;
					
				}
				
				
				
				/* ------------ Hardware Monitor ------------ */
				#custom-hardwareMonitor {
					background: alpha(${colors.base00},0.4);
					color: alpha(${colors.base06},0.9);
					margin: 6px; 
					padding: 0px 8px;
					border-radius: 5px;
				}
				
				/* ------------ System Tray ------------ */
				#tray {
					background: alpha(${colors.base00},0.4);
					color: alpha(${colors.base06},0.9);
					margin: 4px; 
					padding: 0px 8px;
					border-radius: 500px;
				}
				
				/* ------------ Right Modules ------------ */
				#network,
				#pulseaudio,
				#custom-updates,
				#clock {
					background: alpha(${colors.base01},0.8);
					color: alpha(${colors.base06},0.9);
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
					background: alpha(${colors.base0D},0.7);
					color: alpha(${colors.base06},1);
					font-weight: 800; 
				}
				
			'';	
		};	
	};	
}
