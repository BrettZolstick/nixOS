{ config, pkgs, ...}:

{
	# Imports
	imports = [ /etc/nixos/hardware-configuration.nix ];

	# Initial install version
	system.stateVersion = "25.05";

	# Bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Use latest kernel
	boot.kernelPackages = pkgs.linuxPackages_latest;

	# Networking
	networking.hostName = "ethanDesktop";
	networking.networkmanager.enable = true;

	# Time zone
	time.timeZone = "America/NewYork";

	# Internationalization
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# X11 Keymap
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};	

	# Fonts
	fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
	
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Experimental Features
	nix.settings.experimental-features = [ "flakes" "nix-command" ];

	# Users
	users.users.ethan = {
		isNormalUser = true;
		description = "Ethan";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
		shell = pkgs.fish;
	};

	# Services
	services.displayManager.ly.enable = true;
	services.pipewire.enable = true;

	# Programs
	programs.firefox.enable = true;
	programs.hyprland.enable = true;
	programs.waybar.enable = true;
	programs.fish.enable = true;
	programs.steam.enable = true;

	# System Packages	
	environment.systemPackages = with pkgs; [
		# Base System
		micro		# minimal text editor (nano if it was actually good lol)
		kitty 		# terminal emulator
		fish		# shell
		git			# version control
		cifs-utils	# for mounting windows network shares
		tree		# command line tool to show directory trees
		mpvpaper	# video wallpapers (images work too)
		wofi		# app launcher

		# Additional
		fastfetch 	# iconic command line tool
				
	];
	
}
