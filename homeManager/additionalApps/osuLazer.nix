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
      ver = "2026.418.0";
    in {
      osu-lazer-bin-custom = prev.appimageTools.wrapType2 {
        pname = "osu!";
        version = ver;
        src = prev.fetchurl {
          url = "https://github.com/ppy/osu/releases/download/${ver}-lazer/osu.AppImage";
          sha256 = "sha256:e75ce367b3b17ed20a976d5ddb10a352169032dc3240aeaf10644f4d79ea8d75";
          # Find hash here: https://github.com/ppy/osu/releases (go to desired release and copy the hash for osu.AppImage)
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
