{
	description = "My NixOS Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		# manages dotfiles
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};


	};
	
	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations = {
			mainDesktop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
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
