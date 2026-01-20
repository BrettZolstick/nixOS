{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    hytaleLauncher.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.hytaleLauncher.enable {
    # Actual content of the module goes here:
    home.packages = [
      inputs.hytale-launcher.packages.${pkgs.system}.default
    ];
  };
}
