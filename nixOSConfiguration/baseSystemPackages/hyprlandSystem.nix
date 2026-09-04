{
  config,
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

    # enabled at system level so that ly can see it
    programs.hyprland.enable = true; 
  };
}
