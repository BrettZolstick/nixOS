{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    osuNeomod.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.osuNeomod.enable {
    # Actual content of the module goes here:

    # Download from here https://neomod.net/
    # chmod +x the neomod executable
    # point the exec below to the neomod executable
    # (steam must be enabled)

    xdg.desktopEntries."osuNeomod" = {
      name = "osu! (Neomod)";
      exec = "steam-run /home/ethan/projects/neomod/neomod";
      icon = ../../assets/lazer.png;
      comment = "A free-to-win rhythm game. Rhythm is just a *click* away!";
      terminal = false;
      mimeType = [
        "application/x-osu-beatmap-archive"
        "application/x-osu-skin-archive"
        "application/x-osu-beatmap"
        "application/x-osu-storyboard"
        "application/x-osu-replay"
        "x-scheme-handler/osu"
      ];
      categories = ["Game"];
      startupNotify = true;
    };
  };
}
