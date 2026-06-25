{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    dolphin.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.dolphin.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [kdePackages.dolphin];
  };
}
