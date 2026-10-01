{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    kittySystem.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.kittySystem.enable {
    # Actual content of the module goes here:

    environment.systemPackages = with pkgs; [kitty];
  };
}
