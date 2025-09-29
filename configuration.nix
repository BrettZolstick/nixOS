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
	programs.steam.enable = true;
	programs.fish.enable = true;

	# System Packages	
	environment.systemPackages = with pkgs; [];
	
}
