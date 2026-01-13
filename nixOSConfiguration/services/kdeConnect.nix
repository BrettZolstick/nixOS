{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    kdeConnect.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.kdeConnect.enable {
    # Actual content of the module goes here:
    # home.packages = with pkgs; [kdePackages.kdeconnect-kde];

    programs.kdeconnect.enable = true;
    
  };
}
