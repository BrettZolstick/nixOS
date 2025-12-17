{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    nvidiaGraphics.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.nvidiaGraphics.enable {
    # Actual content of the module goes here:

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      #powerManagement.enable = true;
      #powerManagement.finegrained = true; # turns off gpu when not in use
      open = false; # use open source driver
      nvidiaSettings = true;
    };
  };
}
