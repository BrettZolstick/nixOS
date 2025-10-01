{
	description = "My NixOS Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		# manages dotfiles
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# makes color palletes that can be used in your nix config
		nix-colors.url = "github:misterio77/nix-colors";
		
	};
	
	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations = {
			mainDesktop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit nix-colors };
				modules = [
					./hosts/mainDesktop.nix
					./users/ethan.nix					
					home-manager.nixosModules.home-manager
				];
			};
			# Additional hosts go here	
			
		};
	};
	
}
