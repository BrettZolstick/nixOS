{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    sshInto.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.sshInto.enable {
    # Actual content of the module goes here:

    # enable ssh
    services.openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        PubkeyAuthentication = true;
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    # enable fail2ban (bans any ips that try and fail to connect too many times)
    services.fail2ban = {
      enable = true;
      maxretry = 10;
      bantime = "24h";
      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
        multipliers = "1 2 4 8 16 32 64";
        maxtime = "31d"; # Do not ban for more than 1 month
        overalljails = true; # Calculate the bantime based on all the violations
      };
    };
  };
}
