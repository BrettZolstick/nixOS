{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    wine.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.wine.enable {
    # Actual content of the module goes here:

    home.packages = with pkgs; [
      # support both 32-bit and 64-bit applications
      #wineWowPackages.stable

      # wine-staging (version with experimental features)
      #wineWowPackages.staging

      # native wayland support (unstable)
      wineWowPackages.waylandFull

      # winetricks (all versions)
      winetricks
    ];
  };
}
