{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    musescore.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.musescore.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [
      musescore
      muse-sounds-manager
    ];
  };
}
