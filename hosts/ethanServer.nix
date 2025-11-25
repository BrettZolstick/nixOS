{ config, pkgs, lib, ...}: {

	imports = [ 
		# Imports hardware-configuration.nix from the default location
		# this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
		/etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

	 	# include a list of all .nix files recursively under this directory					  v---------------------v			
	]	++	lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../nixOSConfiguration/.);



	# Host specific options
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

	# enable ssh
	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = false;
			PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
		};
	};

	# =========================================================================================================
	# 
	# - Options that you would regularly store in configuration.nix are stored in
	#	nixos/nixOSConfigurations/systemOptions
	#
	# - To make host specific revisions to these options, use lib.mkforce.
	#
	# 		time.timezone = lib.mkForce {
	#			layout = "us";
	#			variant = "";
	#		};
	# 
	# =========================================================================================================



	# =========================================================================================================
	#
	# - All packages in nixOS/nixOSConfiguration/baseSystemConfiguration and nixOS/homeManager were made modular 
	#	and toggleable by using lib.mkOption 
	# 
	# - All modules are enabled by default
	#
	# - To disable a system level module on a host, use the follwing:
	#
	# 		steam.enable 				= false;
	#		ly.enable 					= false;
	# 		alsa-scarlett-gui.enable	= false;
	#
	# - To disable a user level module on a host, specify the user and disable it inside like this:
	#	
	#		home-manager.users.ethan = {
	#			bat.enable 	= false;
	#			tree.enable = false;
	#		};	
	#
	# =========================================================================================================


	hyprlandSystem.enable 			= false;
	ly.enable 						= false;
	mullvad.enable 					= false;
	pipewire.enable 				= false;
	steam.enable 					= false;
	nerdFontsJetBrainsMono.enable	= false;
	
	copyparty.enable 	= true;

	home-manager.users.ethan = {

		kitty.enable 		= true;
		starship.enable 	= true;
		yazi.enable 		= true;



		cifs-utils.enable 	= false;
		grimblast.enable 	= false;
		hyprcursor.enable 	= false;
		hyprland.enable 	= false;
		pwvucontrol.enable 	= false;
		qpwgraph.enable 	= false;
		swaync.enable 		= false;
		waybar.enable 		= false;
		wl-clipboard.enable	= false;
		wofi.enable 		= false;
	};
	
}
