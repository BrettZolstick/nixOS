{
  config,
  lib,
  pkgs,
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

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    services.blueman.enable = true;

    environment.systemPackages = with pkgs ; [
      bluetuith
      bluez
      bluez-tools
    ];

    };
}
