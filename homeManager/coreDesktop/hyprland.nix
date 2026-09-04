{
  config,
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

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      configType = "lua";
     };

    xdg.configFile."hypr/hyprland.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nixOS/homeManager/coreDesktop/hyprland/hyprland.lua";
    };
    
  };
}
