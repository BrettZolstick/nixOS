{ config, pkgs, ... }:

{
	home.username = "ethan";
	home.homeDirectory = "/home/ethan";
	home.stateVersion = "25.05";

	
	programs.git = {
		enable = true;
		userName = "Ethan";
		userEmail = "crazyeman83@gmail.com";
	};

	home.packages = with pkgs; [
		bat 	# replacement for cat (shows file contents)	
	];
}
