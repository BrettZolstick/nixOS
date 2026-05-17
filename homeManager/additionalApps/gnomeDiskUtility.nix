{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    gnomeDiskUtility.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.gnomeDiskUtility.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [gnome-disk-utility];
  };
}
