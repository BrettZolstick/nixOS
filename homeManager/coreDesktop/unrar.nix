{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    unrar.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.unrar.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [unrar];
  };
}
