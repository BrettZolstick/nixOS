{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    unzip.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.unzip.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [
      unzip
      p7zip
    ];
  };
}
