{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    audiobookshelf.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.audiobookshelf.enable {
    # Actual content of the module goes here:

    users.users.audiobookshelf.extraGroups = ["fileSharing"];

    services.audiobookshelf = {
      enable = true;
      host = "0.0.0.0";
      port = 8000;      
      openFirewall = true;
    };
    
    
  };
}
