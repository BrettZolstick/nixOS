{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    atmega32u4udev.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.atmega32u4udev.enable {
    # Actual content of the module goes here:

    services.udev.extraRules = ''
      # Allow normal users to access the ATmega32U4 factory DFU bootloader.
      SUBSYSTEM=="usb", ATTR{idVendor}=="03eb", ATTR{idProduct}=="2ff4", MODE="0666"
    '';

  };
}
