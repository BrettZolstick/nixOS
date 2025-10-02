{config, pkgs, home-manager, lib, ... }: {

	imports = [
		
		../themes/gaucho.nix

	];

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
				
					# import a list of all .nix files recursively under this directory		   		  	v-------------V
			imports = lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../homeManager);

			home.username = "ethan";
			home.homeDirectory = "/home/ethan";
			home.stateVersion = "25.05";
			
		};
	};
		
}
