{ config, pkgs, lib, ...}: {

	imports = [ 
		# Imports hardware-configuration.nix from the default location
		# this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
		/etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

	 	# include a list of all .nix files recursively under this directory					  v---------------------v			
	]	++	lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../nixOSConfiguration/.);



	# Host specific options ################################################

	networking.hostName = "cg";
	networking.networkmanager.enable = true;
	time.timeZone = "America/New_York";
	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

	# give 777 perms to mounted copyparty directory 
	fileSystems."/mnt/copyparty".options = lib.mkAfter [
		"uid=1001"
		"gid=100"
		"file-perms=0777"
		"dir-perms=0777"
		"umask=000"
	];

	# Optional Modules #####################################################

	openTabletDriver.enable 	= false;
	alsaScarlettGui.enable 		= false;
	steam.enable 				= false;

	rcloneShares.enable  	= true;
	samba.enable 			= true;
	sshInto.enable 			= true;
	syncthing.enable 		= true;

	home-manager.users.ethan = {
		firefox.enable 	= true;
		vesktop.enable 	= true;
		office.enable 	= true;
	};
	
}
