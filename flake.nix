{
	description = "My NixOS Flake";



	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};



	outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: {
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ 
				./configuration.nix 
				stylix.nixosModules.stylix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.ethan = import ./home.nix;
					home-manager.backupFileExtension = "backup";
				}
			];
		};
	};


	
}
