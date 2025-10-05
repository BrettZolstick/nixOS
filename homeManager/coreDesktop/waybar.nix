{ config, pkgs, lib, stylix, ... }:

let
        cfg = config.waybar;
        hardwareMonitor = pkgs.writeShellScriptBin "hardware-monitor" ''
                #!/bin/bash

                cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
                ram=$(free -h | awk '/Mem:/ {print $3}')
                gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)



                echo "󰍛 ''${cpu}% |   ''${ram}B | 󰢮  ''${gpu}% ''${null}"
        '';

        gitBehindIndicator = pkgs.writeShellScriptBin "waybar-git-behind" ''
                #!/bin/sh
                set -eu

                repo=${lib.escapeShellArg (cfg.gitRepoPath or "")}

                if [ -z "$repo" ] || [ ! -d "$repo/.git" ]; then
                        printf '{"text":"","tooltip":"No repository configured"}'
                        exit 0
                fi

                if ! git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
                        printf '{"text":"","tooltip":"No repository configured"}'
                        exit 0
                fi

                if ! git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
                        printf '{"text":"","tooltip":"Tracking branch unavailable"}'
                        exit 0
                fi

                status="$(git -C "$repo" status -sb --branch 2>/dev/null | head -n1)"
                behind="$(printf '%s' "$status" | sed -n "s/.*\[behind \([0-9]\+\)\].*/\1/p")"

                text=""
                tooltip="Up to date"

                if [ -n "$behind" ] && [ "$behind" -ne 0 ]; then
                        text="󰅂"
                        if [ "$behind" -eq 1 ]; then
                                tooltip="1 commit behind"
                        else
                                tooltip="$behind commits behind"
                        fi
                fi

                printf '{"text":"%s","tooltip":"%s"}' "$text" "$tooltip"
        '';

        colors = config.lib.stylix.colors.withHashtag;
in
{

	# This is wrapped in an option so that it can be easily toggled elsewhere.
        options = {
                waybar.enable = lib.mkOption {
                        default = true;
                };

                waybar.gitRepoPath = lib.mkOption {
                        type = lib.types.nullOr lib.types.str;
                        default = null;
                        description = ''
                                Absolute path to the Git repository that should surface an
                                icon when it falls behind its upstream remote.
                        '';
                };
        };

        config = lib.mkIf cfg.enable {
                # Actual content of the module goes here:

                home.packages =
                        [ hardwareMonitor ]
                        ++ lib.optionals (cfg.gitRepoPath != null) [ gitBehindIndicator pkgs.gitMinimal ];

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
                                modules-right =
                                        [ "tray" "custom/updates" ]
                                        ++ lib.optional (cfg.gitRepoPath != null) "custom/gitBehind"
                                        ++ [ "custom/clipboard" "network" "pulseaudio" "clock" ];
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
                        } // lib.optionalAttrs (cfg.gitRepoPath != null) {
                                "custom/gitBehind" = {
                                        exec = "${gitBehindIndicator}/bin/waybar-git-behind";
                                        interval = 300;
                                        return-type = "json";
                                        format = "{}";
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
