{ config, pkgs, lib, ...}:

{
	# Imports
	imports = [ 
		# Imports hardware-configuration.nix from the default location
		# this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
		/etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

		# Recursively imports all modules under the specified directory.
		lib.filesystem.listFilesRecursive ./../nixOSConfiguration/.
	];


	# =========================================================================================================
	# 
	# - Options that you would regularly store in configuration.nix are stored in
	#	nixos/nixOSConfigurations/systemOptions
	#
	# - To make host specific revisions to these options, use lib.mkforce.
	#
	# 		time.timezone = lib.mkForce "America/Boise";
	# 
	# =========================================================================================================




	# =========================================================================================================
	#
	# - All packages in nixOS/nixOSConfiguration/baseSystemConfiguration and nixOS/home were made modular 
	#	and toggleable by using lib.mkEnableOption 
	# 
	# - All modules are enabled by default
	#
	# - To disable a specific module on a host, use the follwing. 
	#
	# 		steam.enable	= false;
	#		ly.enable		= false;
	# 		fish.enable 	= false;
	# =========================================================================================================
	

}
