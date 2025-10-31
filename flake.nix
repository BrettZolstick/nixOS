{
	description = "My NixOS Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		#nixpkgs.url = "github:NixOS/nixpkgs/master";

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
			ethanDesktop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/ethanDesktop.nix
					./users/ethan.nix					
					home-manager.nixosModules.home-manager
					inputs.stylix.nixosModules.stylix
				];
			};

			ethanLaptop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/ethanLaptop.nix
					./users/ethan.nix					
					home-manager.nixosModules.home-manager
					inputs.stylix.nixosModules.stylix
				];
			};
			# Additional hosts go here	
			
		};
	};
	
}
