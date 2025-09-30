{ config, pkgs, ... }: {

	# Initial install version
	system.stateVersion = "25.05";

	# Bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Use latest kernel
	boot.kernelPackages = pkgs.linuxPackages_latest;

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
	
}
