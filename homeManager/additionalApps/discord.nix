{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    discord.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.discord.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [discord];
  };
}
