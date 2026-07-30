{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    lutris.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.lutris.enable {
    # Actual content of the module goes here:

    programs.lutris.enable = true;
    
  };
}
