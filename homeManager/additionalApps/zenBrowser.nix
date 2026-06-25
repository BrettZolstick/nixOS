{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    zenBrowser.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.zenBrowser.enable {
    # Actual content of the module goes here:
    home.packages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
