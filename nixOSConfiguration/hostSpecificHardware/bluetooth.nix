{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    bluetooth.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.bluetooth.enable {
    # Actual content of the module goes here:

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    };
}
