{ config, pkgs, lib, stylix, ... }: 

let
        hardwareMonitor = pkgs.writeShellScriptBin "hardware-monitor" ''
                #!/bin/bash

                cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
                ram=$(free -h | awk '/Mem:/ {print $3}')
                gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)



                echo "󰍛 ''${cpu}% |   ''${ram}B | 󰢮  ''${gpu}% ''${null}"
        '';
        gitBehindIcon = "󰊢";
        gitBehindRepo = "${config.home.homeDirectory}/nixOS";
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
                                modules-right = [ "tray" "custom/updates" "custom/clipboard" "custom/gitBehind" "network" "pulseaudio" "clock" ];
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
                                # Show when the configured repository is behind its upstream branch; adjust
                                # 'gitBehindRepo' or the ref in the command to target a different repo/branch.
                                "custom/gitBehind" = {
                                        exec = ''bash -lc '
                                                repo="${gitBehindRepo}"
                                                [ -d "$repo/.git" ] || exit 0
                                                behind=$(git -C "$repo" rev-list --left-right --count HEAD...@{upstream} 2>/dev/null | awk "{print \$2}")
                                                if [ "${behind:-0}" -gt 0 ]; then
                                                        printf "%s\n" "${gitBehindIcon}"
                                                fi
                                        '''';
                                        interval = 300;
                                        format = "{}";
                                        tooltip = "Local branch is behind upstream";
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
