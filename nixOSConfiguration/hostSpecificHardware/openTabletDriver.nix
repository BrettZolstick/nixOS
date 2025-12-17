{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    openTabletDriver.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.openTabletDriver.enable {
    # Actual content of the module goes here:

    hardware.opentabletdriver.enable = true;
  };
}
