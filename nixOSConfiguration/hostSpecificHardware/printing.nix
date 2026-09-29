{
  config,
  lib,
  pkgs,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    printing.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.printing.enable {
    # Actual content of the module goes here:

    services.printing = {
      enable = true;
      browsed.enable = true;
      cups-pdf.enable = true;
      drivers = with pkgs; [
        cups-filters
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    
  };
}
