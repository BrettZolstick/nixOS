{ config, pkgs, lib, ... }:
let
	sources = import ./nix/sources.nix;
	nixpkgs-update = import sources.nixpkgs-update {};
in
{

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		nixpkgsUpdate.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.nixpkgsUpdate.enable {
		# Actual content of the module goes here:

		home.packages = [ nixpkgs-update ];
		
	};	
}
