{
	description = "My NixOS Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		# manages dotfiles
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";			
		};

	};
	
	outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: {
		nixosConfigurations = {
			mainDesktop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/mainDesktop.nix
					./users/ethan.nix					
					home-manager.nixosModules.home-manager
					inputs.stylix.nixosModules.stylix
				];
			};
			# Additional hosts go here	
			
		};
	};
	
}
