{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    chromium.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.chromium.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [ungoogled-chromium google-chrome];
  };
}
