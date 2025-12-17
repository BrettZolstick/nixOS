{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    obsStudio.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.obsStudio.enable {
    # Actual content of the module goes here:
    programs.obs-studio.enable = true;
  };
}
