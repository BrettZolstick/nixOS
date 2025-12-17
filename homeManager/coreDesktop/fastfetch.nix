{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    fastfetch.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.fastfetch.enable {
    # Actual content of the module goes here:
    programs.fastfetch.enable = true;
  };
}
