{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    ventoy.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.ventoy.enable {
    # Actual content of the module goes here:
    environment.systemPackages = with pkgs; [ventoy-full-qt];

    nixpkgs.config.permittedInsecurePackages = ["ventoy-qt5-1.1.17"];
  };
}
