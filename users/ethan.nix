{config, pkgs, home-manager, ... }: {

	users.users.ethan = {
		isNormalUser = true;
		description = "Ethan";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
		shell = pkgs.fish;
	};



	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtension = "backup";
		users.ethan = { ... }: {
			imports = [ ../home.nix ];
			home.username = "ethan";
			home.homeDirectory = "/home/ethan";
			home.stateVersion = "25.05";
		};
	};


	
}
