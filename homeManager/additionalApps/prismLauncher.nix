{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    prismLauncher.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.prismLauncher.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [prismlauncher];

    xdg.desktopEntries."GregTech: New Horizons" = {
      name = "GregTech: New Horizons (GTNH)";
      exec = "prismlauncher --launch GregtechNewHorizons";
      comment = "Greg Tech New Horizons";
      terminal = false;
      startupNotify = true;
    };
  };
}
