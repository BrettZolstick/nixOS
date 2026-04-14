{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    webDrivers.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.webDrivers.enable {
    # Actual content of the module goes here:

    # Enable this to use web drivers, disable it when done.
    # 
    # sudo udevadm control --reload-rules
    # sudo udevadm trigger
    services.udev.extraRules = ''
      KERNEL=="hidraw*", MODE="0666"
    '';
   
  };
}
