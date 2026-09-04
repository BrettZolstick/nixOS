{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    powershell.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.powershell.enable {
    # Actual content of the module goes here:

    home.packages = with pkgs; [
      powershell
    ];

    xdg.configFile."powershell/Microsoft.PowerShell_profile.ps1".text = ''
        # Set Environment Variables
        $env:EDITOR = "hx"
        $env:VISUAL = "hx"

        # Initialize Starship
        Invoke-Expression (& '/etc/profiles/per-user/ethan/bin/starship' init powershell --print-full-init | Out-String)

        # Aliases/Functions
        function rbs {
          sudo nixos-rebuild switch --flake ~/nixOS#$(hostname) --impure --show-trace 
        }
  
      '';
    
  };
}




