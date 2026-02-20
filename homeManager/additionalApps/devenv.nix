{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    devenv.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.devenv.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [devenv];
  };
}
