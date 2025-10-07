{ config, pkgs, lib, ... }: {
	
	environment.systemPackages = with pkgs; [ nix-tree ];
		
}
