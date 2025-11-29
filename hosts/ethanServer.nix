{ config, pkgs, lib, ...}: {

	imports = [ 
		# Imports hardware-configuration.nix from the default location
		# this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
		/etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

	 	# include a list of all .nix files recursively under this directory					  v---------------------v			
	]	++	lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../nixOSConfiguration/.);



	# Host specific options ################################################

	networking.hostName = "ethanServer";
	networking.networkmanager.enable = true;
	time.timeZone = "America/New_York";
	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

	# Switch bootloader to grub (non-uefi system)
	systemdBoot.enable = false;
	boot.loader = {
		systemd-boot.enable = false;
		grub.enable = true;
		grub.device = "/dev/nvme0n1";
	};

	# Optional Modules #####################################################

	hyprlandSystem.enable 			= false;
	ly.enable 						= false;
	mullvad.enable 					= false;
	pipewire.enable 				= false;
	steam.enable 					= false;
	nerdFontsJetBrainsMono.enable	= false;
	
	copyparty.enable 			= true;
	sshInto.enable 				= true;
	minecraftGTNHServer.enable 	= true;

	home-manager.users.ethan = {

		cifs-utils.enable 	= false;
		grimblast.enable 	= false;
		hyprcursor.enable 	= false;
		hyprland.enable 	= false;
		pwvucontrol.enable 	= false;
		qpwgraph.enable 	= false;
		swaync.enable 		= false;
		waybar.enable 		= false;
		wofi.enable 		= false;
		
		kitty.enable 		= true;
		starship.enable 	= true;
		yazi.enable 		= true;
		wl-clipboard.enable	= true;

	};
	
}
