{
  config,
  pkgs,
  lib,
  ...
}: let
  osuOverlay = (
    # overlay to build the specified version of osu! lazer
    #  -> when the game updates, you cannot submit scores until you update to the latest version
    #     this overlay lets you explicilty build the latest version as soon as it releases
    final: prev: let
      ver = "2025.1029.1";
    in {
      osu-lazer-bin-custom = prev.appimageTools.wrapType2 {
        pname = "osu!";
        version = ver;
        src = prev.fetchurl {
          url = "https://github.com/ppy/osu/releases/download/${ver}-lazer/osu.AppImage";
          sha256 = "sha256:971f91376d2c3e21befa92d2d205ba8b1218c37fa0d4a18232b021816fb2648c";
          # Find hash here: https://github.com/ppy/osu/releases
          # Alternatively, rebuild with this and copy hash from error log.
          #sha256 = lib.fakeHash;
        };
        extraPkgs = pkgs:
          with pkgs; [
            icu
          ];
      };
    }
  );

  # Create a local version of pkgs that includes osuOverlay
  pkgsWithOverlays = pkgs.extend osuOverlay;
in {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    osuLazer.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.osuLazer.enable {
    # Actual content of the module goes here:

    home.packages = [
      # Official from nixpkgs
      #pkgs.osu-lazer-bin

      # Version from my overlay above (can be used to immediately download the latest version as soon as it releases)
      pkgsWithOverlays.osu-lazer-bin-custom
    ];

    xdg.desktopEntries."osu!" = {
      name = "osu!";
      exec = "env PIPEWIRE_LATENCY=128/48000 PIPEWIRE_QUANTUM=128/48000 osu!";
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
