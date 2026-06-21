{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    osuStable.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.osuStable.enable {
    # Actual content of the module goes here:
    home.packages = [
      inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    ];
  };
}
