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

    services.jellyfin = {
      enable = true;
      user = "jellyfin";
      group = "filesharing";
    };
    
  };
}
