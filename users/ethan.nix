{config, pkgs, home-manager, lib, ... }: {

	imports = [
		
		../themes/gaucho.nix

		#../themes/niceMountain.nix
		#../themes/theLight.nix
		#../themes/buriedInTheSand.nix

	];

	users.users.ethan = {
		isNormalUser = true;
		description = "Ethan";
		extraGroups = [ "networkmanager" "wheel" "inputs" "audio" "copyparty"];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOndt9pcrojkgDiVXSVZNhxeQYKtgliiaa4AfjSzzgL4 sshFromEthanDesktop"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEbZKk4p+nxPj9GIkQ/2iFAnOPBx3Pa56hF4nrn2NLYR sshFromEthanLaptop"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvB+N3V0bdBaYeK4BrrWEvc4BGNMUcsLr63pPtHiyHR ethanWorkDesktop"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMx4aJOCFybYEqWfLZD8Q2GDa4jvTV+I02Nda4LmqUUn sshFromEthanPhone"
		];
		packages = with pkgs; [];
		shell = pkgs.fish;
	};



	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtension = "backup";
		users.ethan = { ... }: {
				
					# import a list of all .nix files recursively under this directory		   		  	v-------------V
			imports = lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../homeManager);
			home.username = "ethan";
			home.homeDirectory = "/home/ethan";
			home.stateVersion = "25.05";	
			home.pointerCursor = {
			    name = "Nordzy-cursors";
			    package = pkgs.nordzy-cursor-theme;
			    size = 22;
		  	};
		
		};
	};
		
}
