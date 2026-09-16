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

    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [dnsmasq];

    # To enable the default network automatically at boot, run:
    # virsh net-autostart default

    networking.firewall.trustedInterfaces = [ "virbr0" ];

    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
    

    
  };
}
