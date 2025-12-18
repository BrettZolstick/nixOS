{
  config,
  lib,
  pkgs,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    updateAsinReference.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.updateAsinReference.enable {
    # Actual content of the module goes here:

    environment.systemPackages = [ pkgs.powershell ];
    
    systemd.services.updateAsinReference = {
      description = "Runs a powershell script to update estimated sale prices of laptops based on Amazon's pricing";
      serviceConfig = {
        Type = "oneshot";
        User = "updateAsinReference";
        Group = "Filesharing";
        WorkingDirectory = "/srv/copyparty/prep/NewQA/EpcListEnhancer2";
        ExecStart = "${pkgs.powershell}/bin/pwsh -NoProfile -NonInteractive -File /srv/copyparty/prep/NewQA/EpcListEnhancer2/UpdateAsinReference.ps1";
      };
    };

    systemd.timers.weekly-updateAsinReference = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "Mon *-*-* 05:00:00";
        Persistant = true;
      };
    };
    
  };
}
