{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    nerdFontsJetBrainsMono.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.nerdFontsJetBrainsMono.enable {
    # Actual content of the module goes here:

    fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono];
  };
}
