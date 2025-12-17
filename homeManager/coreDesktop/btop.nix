{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    btop.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.btop.enable {
    # Actual content of the module goes here:

    programs.btop.enable = true;

    # fix btops desktop entry so it actually works in wofi
    xdg.desktopEntries.btop = {
      name = "btop++";
      type = "Application";
      exec = "kitty -e btop"; # directly launch in kitty
      terminal = false; # false because techically its launching kitty, not btop
      icon = "btop";
      categories = ["System" "Utility"];
    };
  };
}
