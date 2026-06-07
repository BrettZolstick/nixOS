{
  config,
  lib,
  ...
}: let
  keysWithPasswords = [
    "~/.ssh/sshFromEthanDesktop-id_ed25519"
    "~/.ssh/sshFromEthanLaptop-id_ed25519"
    "~/.ssh/sshFromEthanServer-id_ed25519"
    "~/.ssh/sshFromCg-id_ed25519"
  ];
in {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    sshFrom.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.sshFrom.enable {
    # Actual content of the module goes here

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "ethanServer" = {
          HostName = "ethan.cookiegroup.net";
          Port = 22022;
          # HostName = "192.168.68.67";
          # Port = 22;
          User = "ethan";
          IdentityFile = keysWithPasswords;
          IdentitiesOnly = true;
        };
        "ethanDesktop" = {
          HostName = "ethan.cookiegroup.net";
          # HostName = "192.168.68.53";
          Port = 22021;
          User = "ethan";
          IdentityFile = keysWithPasswords;
          IdentitiesOnly = true;
        };
        "ethanLaptop" = {
          # LAN only
          HostName = "192.168.68.69";
          User = "ethan";
          IdentityFile = keysWithPasswords;
          IdentitiesOnly = true;
        };
        "cg" = {
          HostName = "office.cookiegroup.net";
          Port = 22022;
          User = "ethan";
          IdentityFile = keysWithPasswords;
          IdentitiesOnly = true;
        };
      };
    };
  };
}
