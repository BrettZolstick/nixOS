{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    hyprlandSystem.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.hyprlandSystem.enable {
    # Actual content of the module goes here:

    programs.hyprland.enable = true;
  };
}
