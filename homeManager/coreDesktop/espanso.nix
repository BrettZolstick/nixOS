{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    espanso.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.espanso.enable {
    # Actual content of the module goes here:

    serviecs.espanso = {
      enable = true;
      waylandSupport = true;
      matches = [
        {
          base = {
            matches = [
              {
                trigger = ":thanks";
                replace = "Thanks and have a nice day,\nEthan Keats";
              }
              
            ];
          };
        }
      ];

      
    };
  };
}
