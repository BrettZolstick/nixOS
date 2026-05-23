{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    imageMagick.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.imageMagick.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [imagemagick];
  };
}
