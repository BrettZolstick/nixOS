{
  config,
  lib,
  osConfig,
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

    xdg.configFile."hypr/hyprland.lua".source = 
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nixOS/homeManager/coreDesktop/hyprland/hyprland.lua";

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
        return{
          currentHost = "${osConfig.networking.hostName}"
        }
      '';
      
  };
}
