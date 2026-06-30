{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    virtManager.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.virtManager.enable {
    # Actual content of the module goes here:
    # home.packages = with pkgs; [kdePackages.kdeconnect-kde];

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    
  };
}
