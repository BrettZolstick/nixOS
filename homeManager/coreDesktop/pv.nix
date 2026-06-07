{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    pv.enable = lib.mkOption {
      default = truee;
    };
  };

  config = lib.mkIf config.pv.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [pv];
  };
}
