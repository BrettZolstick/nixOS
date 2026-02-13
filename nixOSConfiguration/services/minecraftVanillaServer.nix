{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    minecraftVanillaServer.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.minecraftVanillaServer.enable {

    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      package = let
        version = "1.21.11";
        url = "https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar";
        sha256 = "f83b8e093865806f931c7e34aae41b177d4c076335263dd124c75d6d65dd1726";
      in (pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: rec {
        name = "minecraftServers.vanilla-${version}";
        inherit version;
        src = pkgs.fetchurl {
          inherit url sha256;
        };
      }));
      serverProperties = {
        server-port = 25566;
        difficulty = 3;
        gamemode = 1;
        max-players = 5;
        motd = "Epic Skyblock";
        white-list = false;
        enable-rcon = true;
        "rcon.password" = "block";
        "rcon.port" = 24565;
      };
      jvmOpts = "-Xms6092M -Xmx6092M";
    };
    environment.systemPackages = [ pkgs.mcrcon ];    
  };
}
