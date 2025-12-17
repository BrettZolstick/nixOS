{
  config,
  pkgs,
  lib,
  stylix,
  ...
}: let
  hardwareMonitor = pkgs.writeShellScriptBin "hardware-monitor" ''
    #!/bin/bash

    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f\n", 100 - $8}')
    ram=$(free -h | awk '/Mem:/ {print $3}')
    #gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)

    if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi -L >/dev/null 2>&1; then
    	gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    else [ -r /sys/class/drm/card1/device/gpu_busy_percent ]
    	gpu=$(cat /sys/class/drm/card1/device/gpu_busy_percent)
    fi

    echo "󰍛 ''${cpu}% |   ''${ram}B | 󰢮  ''${gpu}% ''${null}"
  '';

  flakeRoot = "~/nixOS";
  gitBehind = pkgs.writeShellScriptBin "git-behind" ''

    #!/usr/bin/env bash

    set -euo pipefail

    # fetch remote repo
    timeout 3s bash -c "git -C ${flakeRoot} fetch" >/dev/null 2>&1 || true

    # check if behind
    if git -C ${flakeRoot} status -uno | grep -qF "Your branch is behind"; then
    	printf '{"text":" ","tooltip":"Your Flake repo at ${flakeRoot} is behind","class":["behind"]}'
    else
    	printf '{"text":"","class":["hidden"]}\n'
    fi

  '';

  batteryMonitor = pkgs.writeShellScriptBin "battery-monitor" ''
    #!/bin/bash

    status=$(cat /sys/class/power_supply/BAT0/status)

    # Power Usage
    current=$(cat /sys/class/power_supply/BAT0/current_now)  # µA
    voltage=$(cat /sys/class/power_supply/BAT0/voltage_now)  # µV
    abs_current=$(awk -v c="$current" 'BEGIN {if(c<0) c*=-1; print c}')
    wattage=$(awk -v c="$abs_current" -v v="$voltage" 'BEGIN {printf "%.2f", c*v/1e12}')

    # Capacity info
    charge_now=$(cat /sys/class/power_supply/BAT0/charge_now)     # µAh
    charge_full=$(cat /sys/class/power_supply/BAT0/charge_full)   # µAh
    voltage_v=$(awk -v v="$voltage" 'BEGIN {print v/1e6}')        # V
    battery_percentage=$(awk -v now="$charge_now" -v full="$charge_full" 'BEGIN {print int((now/full)*100)}')


    # Remaining Watt Hours
    remaining_wh=$(awk -v q="$charge_now" -v v="$voltage_v" 'BEGIN {print (q/1e6)*v}')
    capacity_wh=$(awk -v q="$charge_full" -v v="$voltage_v" 'BEGIN {print (q/1e6)*v}')
    needed_wh=$(awk -v full="$capacity_wh" -v now="$remaining_wh" 'BEGIN {print full-now}')



    if [ "$status" == "$null" ]; then
    	printf '{"text":"","class":["hidden"]}\n'
    fi

    if [ "$status" == "Not charging" ] || [ "$status" == "Full" ]; then
    	printf '{"text":"  %s%%","class":["Full"]}\n' "$battery_percentage"
    fi

    if [ "$status" == "Discharging" ]; then
        time=$(awk -v e="$remaining_wh" -v p="$wattage" 'BEGIN {if (p > 0.001) printf "%.1f", e/p; else print "∞"}')
    	printf '{"text":"  %s%% |  %sW %sh","class":["Discharging"]}\n' "$battery_percentage" "$wattage" "$time"

    fi

    if [ "$status" == "Charging" ]; then
    	time=$(awk -v e="$needed_wh" -v p="$wattage" 'BEGIN {if (p > 0.001) printf "%.1f", e/p; else print "∞"}')
    	printf '{"text":"  %s%% |  %sW %sh","class":["Charging"]}\n' "$battery_percentage" "$wattage" "$time"
    fi

  '';

  colors = config.lib.stylix.colors.withHashtag;
in {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    waybar.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.waybar.enable {
    # Actual content of the module goes here:

    home.packages = [
      hardwareMonitor
      gitBehind
      batteryMonitor
    ];

    # disable stylix auto themeing
    stylix.targets.waybar.enable = false;
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      systemd.target = "hyprland-session.target";

      settings = [
        {
          layer = "top";
          position = "top";
          modules-left = ["hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/hardwareMonitor" "custom/batteryMonitor" "custom/gitBehind"];
          modules-right = ["tray" "custom/updates" "custom/clipboard" "network" "pulseaudio" "custom/notification" "clock"];
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
          "custom/batteryMonitor" = {
            exec = "${batteryMonitor}/bin/battery-monitor";
            interval = 1;
            return-type = "json";
            format = "{text}";
            tooltip = false;
          };
          "custom/gitBehind" = {
            exec = "${gitBehind}/bin/git-behind";
            interval = 61;
            return-type = "json";
            format = "{text}";
            on-click = "kitty --directory ~/nixOS";
            tooltip = true;
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

          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };

          "clock" = {
            format = "{:%a %m.%d.%Y %I:%M %p}";
            tooltip = false;
          };
        }
      ];

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
        /* ------------ Battery Monitor ------------ */
        #custom-batteryMonitor {
        	background: alpha(${colors.base00},0.4);
        	color: alpha(${colors.base06},0.9);
        	margin: 6px;
        	padding: 0px 8px;
        	border-radius: 5px;
        }
        /* ------------ Flake Repo Status (gitBehind) ------------ */
        #custom-gitBehind {
        	background: alpha(${colors.base06},0.8);
        	color: alpha(${colors.base00},1);
        	font-size: 16px;
        	font-weight: bold;
        	margin: 2px;
        	padding-top: 0px;
        	padding-bottom: 0px;
        	padding-right: 4px;
        	padding-left: 7px;
        	border-radius: 100px;
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
        #custom-notification,
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

        #custom-notification{
        	margin-right: 2px;
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
