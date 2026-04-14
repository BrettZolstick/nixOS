{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    pulsar.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.pulsar.enable {
    # Actual content of the module goes here:

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="3710", ATTRS{idProduct}=="5406", TAG+="uaccess"
      SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="3710", ATTRS{idProduct}=="5406", TAG+="uaccess"    
    '';
    
  };
}
