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

    stylix.url = "github:nix-community/stylix";

    copyparty.url = "github:9001/copyparty";

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nix-gaming.url = "github:fufexan/nix-gaming";
    
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    copyparty,
    hytale-launcher,
    nixos-wsl,
    ...
  } @ inputs: {
    nixosConfigurations = {
      ethanDesktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit copyparty;
        };
        modules = [
          ./hosts/ethanDesktop.nix
          ./users/ethan.nix
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = {inherit inputs;};}
          inputs.stylix.nixosModules.stylix
          copyparty.nixosModules.default
        ];
      };

      ethanLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/ethanLaptop.nix
          ./users/ethan.nix
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = {inherit inputs;};}
          inputs.stylix.nixosModules.stylix
          copyparty.nixosModules.default
        ];
      };

      ethanServer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit copyparty;
        };
        modules = [
          ./hosts/ethanServer.nix
          ./users/ethan.nix
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = {inherit inputs;};}
          inputs.stylix.nixosModules.stylix
          copyparty.nixosModules.default
        ];
      };

      cg = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit copyparty;
        };
        modules = [
          ./hosts/cg.nix
          ./users/ethan.nix
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = {inherit inputs;};}
          inputs.stylix.nixosModules.stylix
          copyparty.nixosModules.default
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/wsl.nix
          ./users/ethan.nix
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = {inherit inputs;};}
          inputs.stylix.nixosModules.stylix
          copyparty.nixosModules.default
          nixos-wsl.nixosModules.default
        ];
      };
      plexus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/plexus.nix
          ./users/ethanPlexus.nix
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = {inherit inputs;};}
          inputs.stylix.nixosModules.stylix
          copyparty.nixosModules.default
          nixos-wsl.nixosModules.default
        ];
      };
      # Additional hosts go here
    };
  };
}
