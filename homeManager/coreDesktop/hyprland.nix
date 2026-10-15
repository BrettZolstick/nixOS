{
  config,
  lib,
  osConfig,
  pkgs,
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

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      configType = "lua";
      extraConfig = "require('hyprland.hyprland')";
     };

    xdg.configFile."hypr/hyprland".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nixOS/homeManager/coreDesktop/hyprland";

    xdg.configFile."hypr/stylix.lua".text = ''
      return {
        base00 = "${config.lib.stylix.colors.withHashtag.base00}",
        base01 = "${config.lib.stylix.colors.withHashtag.base01}",
        base02 = "${config.lib.stylix.colors.withHashtag.base02}",
        base03 = "${config.lib.stylix.colors.withHashtag.base03}",
        base04 = "${config.lib.stylix.colors.withHashtag.base04}",
        base05 = "${config.lib.stylix.colors.withHashtag.base05}",
        base06 = "${config.lib.stylix.colors.withHashtag.base06}",
        base07 = "${config.lib.stylix.colors.withHashtag.base07}",
        base08 = "${config.lib.stylix.colors.withHashtag.base08}",
        base09 = "${config.lib.stylix.colors.withHashtag.base09}",
        base0A = "${config.lib.stylix.colors.withHashtag.base0A}",
        base0B = "${config.lib.stylix.colors.withHashtag.base0B}",
        base0C = "${config.lib.stylix.colors.withHashtag.base0C}",
        base0D = "${config.lib.stylix.colors.withHashtag.base0D}",
        base0E = "${config.lib.stylix.colors.withHashtag.base0E}",
        base0F = "${config.lib.stylix.colors.withHashtag.base0F}",
      }
    '';

      xdg.configFile."hypr/host.lua".text = ''
        return "${osConfig.networking.hostName}"
      '';

    services.hyprpaper.enable = true;

    # this is to fix the hyprpaper service not starting because it tries to start before wayland
    systemd.user.services.hyprpaper = {
      Unit = {
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general.hide_cursor = true;
        background = lib.mkForce {
          color = "rgba(0, 0, 0, 1.0)";
        };
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = ''
            hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })'    
          '';
          # on_unlock_cmd = "${todoistToWorkspace1}";
        };
        listener = [
          {
            timeout = 120;
            on-timeout =
              if lib.elem osConfig.networking.hostName == ["ethanDesktop" "cg"]
              then "hyprlock"
              else ''
                hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' && hyprlock   
              '';
            on-resume = ''
              hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })'    
            '';
          }
        ];
      };
    };

    stylix.targets.hyprland.enable = false;


    systemd.user.services.polkit-kde-agent = {
      Unit = {
        Description = "KDE Polkit Authentication Agent"; # Human-readable service name
        After = [ "graphical-session.target" ]; # Order startup after the graphical session
        PartOf = [ "graphical-session.target" ]; # Stop when the graphical session stops
      };

      Service = {
        Type = "simple"; # Agent runs continuously in the foreground
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"; # Use the executable's Nix store path
        Environment = "QT_STYLE_OVERRIDE=Fusion"; # Avoid the Kvantum style that causes the authentication dialog to crash
        Restart = "on-failure"; # Restart if the process crashes
      };

      Install = {
        WantedBy = [ "graphical-session.target" ]; # Start automatically with the graphical session
      };
    };
  };
}
