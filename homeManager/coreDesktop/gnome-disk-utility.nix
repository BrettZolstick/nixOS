{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    gnome-disk-utility.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.gnome-disk-utility.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [gnome-disk-utility];
  };
}
