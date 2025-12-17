{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    cifs-utils.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.cifs-utils.enable {
    # Actual content of the module goes here:

    home.packages = with pkgs; [cifs-utils];
  };
}
