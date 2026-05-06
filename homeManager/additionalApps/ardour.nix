{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    ardour.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.ardour.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [ardour];
  };
}
