{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    atmega32u4.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.atmega32u4.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [ dfu-programmer ];
  };
}
