{
  ...
}: {
  # On hyprland 0.53 and above, see documentation for named rules here:
  # https://wiki.hypr.land/Configuring/Window-Rules/

  wayland.windowManager.hyprland.extraConfig = ''
    windowrule {
      name = ignoreAllMaximizeRequests
      match:class = *
      suppress_event = maximize
    }
    
    windowrule {
      name = noFirefoxTransparency
      match:class = firefox
      opacity = 1.0 override 1.0 override
    }

    windowrule {
      name = forcePrismLauncherTransparency
      match:class = org.prismlauncher.PrismLauncher
      opacity = 0.93 override 0.91 override
    }

    windowrule {
      name = disableVideosTransparency
      match:content = video
      opacity = 1.0 override 1.0 override
    }

    windowrule {
      name = disableDiscordTransparency
      match:class = (vesktop|discord)
      opacity = 1.0 override 1.0 override
    }

    windowrule {
      name = enableTearingOsu
      match:class = osu!
      immediate = true
    }    

    windowrule {
      name = enableTearingGlobal
      match:class = *
      immediate = true
    }

    windowrule {
      name = wofiWindowRules
      match:class = wofi
      rounding = 10 override
      rounding_power = 2 override
      border_size = 4 override
    }

    windowrule {
      name = workspaceTwoApps
      match:class = (vesktop|discord|Todoist)
      workspace = 2
    }

    windowrule {
      name = openSteamGamesInWorksapceOne
      match:class = ^(steam_app_[0-9]+)$
      workspace = 1
      fullscreen = true
    }
  '';
}
