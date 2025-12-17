{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    mpv.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.mpv.enable {
    # Actual content of the module goes here:

    programs.mpv.enable = true;
  };
}
