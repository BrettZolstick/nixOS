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


	sylix.image = ~/wallpapers/haelos-buriedInTheSand.jpg

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



}
