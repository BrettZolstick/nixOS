{
  ...
}: {
  # On hyprland 0.53 and above, see documentation for named rules here:
  # https://wiki.hypr.land/Configuring/Window-Rules/

  wayland.windowManager.hyprland.settings.window_rule = [
    {
      name = "ignoreAllMaximizeRequests";
      match = { class = "*"; };
      suppress_event = "maximize";
    }
    
    {
      name = "noFirefoxTransparency";
      match = { class = "firefox"; };
      opacity = "1.0 override 1.0 override";
    }

    {
      name = "forcePrismLauncherTransparency";
      match = { class = "org.prismlauncher.PrismLauncher"; };
      opacity = "0.93 override 0.91 override";
    }

    {
      name = "forceFurnaceTransparency";
      match = { class = "org.tildearrow.furnace"; };
      opacity = "0.93 override 0.91 override";
    }
    
    {
      name = "disableVideosTransparency";
      match = { content = "video"; };
      opacity = "1.0 override 1.0 override";
    }

    {
      name = "disableDiscordTransparency";
      match = { class = "(vesktop|discord)"; };
      opacity = "1.0 override 1.0 override";
    }

    {
      name = "enableTearingOsu";
      match = { class = "osu!"; };
      immediate = true;
    }    

    {
      name = "enableTearingGlobal";
      match = { class = "*"; };
      immediate = true;
    }

    {
      name = "wofi";
      match = { class = "wofi"; };
      rounding = "10 override";
      rounding_power = "2 override";
      border_size = "4 override";
    }

    {
      name = "workspaceTwoApps";
      match = { class = "(vesktop|discord|Todoist)"; };
      workspace = "2";
    }

    {
      name = "openSteamGamesInWorksapceOne";
      match = { class = "^(steam_app_[0-9]+)$"; };
      workspace = "1";
      fullscreen = true;
    }

    {
      name = "noFullscreenForRailWindows";
      match = { class = "^(RAIL:.*)$"; };
      suppress_event = "fullscreen maximize fullscreenoutput";
    }
  ];
}
