{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    nixTree.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.nixTree.enable {
    # Actual content of the module goes here:

    environment.systemPackages = with pkgs; [nix-tree];
  };
}
