{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    aria2.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.aria2.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [aria2];
  };
}
