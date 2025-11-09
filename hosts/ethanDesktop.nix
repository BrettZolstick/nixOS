{ config, pkgs, lib, ...}: {

	imports = [ 
		# Imports hardware-configuration.nix from the default location
		# this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
		/etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

	 	# include a list of all .nix files recursively under this directory					  v---------------------v			
	]	++	lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../nixOSConfiguration/.);



	# Host specific options
	networking.hostName = "ethanDesktop";
	networking.networkmanager.enable = true;
	time.timeZone = "America/New_York";
	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

	# Udev rules
	services.udev.extraRules = ''
		# Prevent Hyprland's tablet settings from interfering with Open Tablet Driver
		ATTRS{name}=="Wacom One by Wacom M Pen", ENV{LIBINPUT_IGNORE_DEVICE}="1"

		# Generic Wooting devices
		SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", TAG+="uaccess"
		SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", TAG+="uaccess"
	'';


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

	AMDGraphics.enable 		= true;
	cifsShares.enable 		= true;
	openTabletDriver.enable = true;
	alsaScarlettGui.enable 	= true;

	copyparty.enable 		= true;

	home-manager.users.ethan = {
		aniCli.enable 			= true;
		blender.enable 			= true;
		calibre.enable 			= true;
		firefox.enable 			= true;
		freecad.enable 			= true;
		freerdp.enable 			= true;
		kicad.enable 			= true;
		lingot.enable 			= true;
		orcaSlicer.enable 		= true;
		osuLazer.enable 		= true;
		sigil.enable 			= true;
		todoist.enable 			= true;
		vesktop.enable 			= true;
		wootility.enable 		= true;
		prismLauncher.enable 	= true;
		gamescope.enable 		= true;
		mangohud.enable  		= true;
		missionCenter.enable 	= true;
		audacity.enable 		= true;
		renoise.enable 			= true;
		furnace.enable 			= true;
		musescore.enable 		= true;
		obsStudio.enable 		= true;
		keyOverlay.enable 		= true;
		krita.enable 			= true;
		figma.enable 			= true;
	};
	
}
