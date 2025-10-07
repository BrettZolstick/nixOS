{ config, pkgs, lib, ... }: {

	environment.systemPackages = with pkgs; [ alsa-scarlett-gui ];
		
}
