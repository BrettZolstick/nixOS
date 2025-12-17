{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    minecraftGTNHServer.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.minecraftGTNHServer.enable {
    # Actual content of the module goes here:

    # make user and group for service
    users.users.minecraftGTNH = {
      isSystemUser = true;
      home = "/srv/minecraftGTNHServer";
      createHome = false;
      group = "minecraftGTNH";
      extraGroups = ["copyparty "];
    };
    users.groups.minecraftGTNH = {};

    # grant file permissions for minecraftGTNH user
    systemd.tmpfiles.rules = [
      "d /srv/minecraftGTNHServer 0750 minecraft -" # creates dir if not exist already
      "Z /srv/minecraftGTNHServer 0750 minecraft minecraft -" # recursively sets perms
    ];

    # install desired packages
    environment.systemPackages = with pkgs; [
      pkgs.javaPackages.compiler.temurin-bin.jre-25
      mcrcon # minecraft remote console
    ];

    # open ports
    networking.firewall.allowedTCPPorts = [25565 24565];

    # create systemd service
    systemd.services.gtnh = {
      description = "Gregtech New Horizons minecraft server";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];

      serviceConfig = {
        WorkingDirectory = "/srv/minecraftGTNHServer";
        User = "minecraftGTNH";
        Group = "minecraftGTNH";
        ExecStart = "/bin/sh /srv/minecraftGTNHServer/startserver-java9.sh";
        Restart = "on-failure";
        RestartSec = 10;
        LimitNOFILE = 65535;
      };

      path = [pkgs.javaPackages.compiler.temurin-bin.jre-25];
    };
  };
}
