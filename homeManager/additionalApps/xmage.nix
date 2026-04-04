{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    xmage.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.xmage.enable {
    # Actual content of the module goes here:

    home.packages = with pkgs;[
      xmage
    ];

    home.activation.createXmageDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.local/share/xmage"
      cp -rn ${pkgs.xmage}/xmage/mage-server/config "$HOME/.local/share/xmage/"
    '';

    systemd.user.services.xmage-local-server = {
      Unit = {
        Description = "XMage Local Server";
      };
      
      Service = {
        Type = "simple";
        StateDirectory = "xmage-local";
        WorkingDirectory = "%h/.local/share/xmage";
        ExecStart = ''
          ${pkgs.bash}/bin/bash -lc 'exec ${pkgs.jdk8}/bin/java -Xms256m -Xmx1024m -jar ${pkgs.xmage}/xmage/mage-server/lib/mage-server-*.jar' 
        '';       
      };
    };
  };
}
