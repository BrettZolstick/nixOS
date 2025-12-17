{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    nixLd.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.nixLd.enable {
    # Actual content of the module goes here:

    programs.nix-ld.enable = true;

    # Optional: pre-register extra libs if your app needs them
    programs.nix-ld.libraries = with pkgs; [
      # add likely deps here if needed:
      # zlib openssl curl libgcc
    ];
  };
}
