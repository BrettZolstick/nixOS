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
		nixosConfigurations = {

			default = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/default.nix
					./users/ethan.nix					
					stylix.nixosModules.stylix
					home-manager.nixosModules.home-manager
				];
			};

			# Additional hosts go here


				
		};
	};
}
