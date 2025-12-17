{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    hyprland.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.hyprland.enable {
    # Actual content of the module goes here:

    home.packages = [pkgs.brightnessctl];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
    };

    services.hyprpaper.enable = true;

    # this is to fix the hyprpaper service not starting because it tries to start before wayland
    systemd.user.services.hyprpaper = {
      Unit = {
        After = ["hyprland-session.target"];
        PartOf = ["hyprland-session.target"];
      };
      Install = {
        WantedBy = ["hyprland-session.target"];
      };
    };

    programs.hyprlock = {
      enable = true;
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 300;
            on-timeout =
              if osConfig.networking.hostName == "ethanDesktop"
              then "hyprlock"
              else "hyprctl dispatch dpms off && hyprlock";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
