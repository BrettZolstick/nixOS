{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    java25.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.java25.enable {
    # Actual content of the module goes here:
    
    home.packages = with pkgs; [
      javaPackages.compiler.temurin-bin.jdk-25
    ];
  };
}
