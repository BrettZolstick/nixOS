{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    flatpak.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.flatpak.enable {
    # Actual content of the module goes here:

    services.flatpak.enable = true;

  };
}
