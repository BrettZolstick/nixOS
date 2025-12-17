{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    steam.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.steam.enable {
    # Actual content of the module goes here:

    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [protontricks];
  };
}
