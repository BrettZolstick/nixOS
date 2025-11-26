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
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxhcqn5hmpiu+eUlEJUnu1L53d1If4HXEXpsTPfrhJJ ethanDesktop"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTzcYjIWJt+H7q4W6fwdsFGp7Uz3EymKWDBo0McQ1uU ethanLaptop"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvB+N3V0bdBaYeK4BrrWEvc4BGNMUcsLr63pPtHiyHR ethanWorkDesktop"
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
