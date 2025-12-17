{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    javaVersions.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.javaVersions.enable {
    # Actual content of the module goes here:

    environment.systemPackages = with pkgs; [
      #temurin-bin
      #zulu
    ];
  };
}
