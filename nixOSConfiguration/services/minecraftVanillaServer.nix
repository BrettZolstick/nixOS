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
      package = pkgs.papermcServers.papermc-1_21_11;
      serverProperties = {
        server-port = 25566;
        difficulty = 3;
        gamemode = 1;
        max-players = 5;
        motd = "Epic Skyblock";
        white-list = false;
        enable-rcon = true;
        rcon.password = "block";
        rcon.port = 24565;
      };
      jvmOpts = "-Xms6092M -Xmx6092M";
    };
    environment.systemPackages = [ pkgs.mcrcon ];    
  };
}
