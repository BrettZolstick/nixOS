{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    winboat.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.winboat.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [winboat];
  };
}
