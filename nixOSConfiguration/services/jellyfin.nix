{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    jellyfin.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.jellyfin.enable {
    # Actual content of the module goes here:
    # home.packages = with pkgs; [kdePackages.kdeconnect-kde];

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      
    };
    
  };
}
