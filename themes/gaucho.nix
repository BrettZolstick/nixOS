{ config, lib, stylix, ...}: {

	options = {
		desktopThemes.gaucho.enable = lib.mkOption {
			default = false;
		};
	};


	config = lib.mkIf config.desktopThemes.enable = {
		stylix.enable = true;

		stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";

		stylix.image = /home/ethan/wallpapers/culprate-gaucho.jpg

		stylix.fonts = {
			serif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Serif";						
			};
			sansSerif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Sans";
			};
			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "Jetbrains Mono Nerd Font";
			};
			emoji = {
				package = pkgs.noto-fonts-emoji;
				name = "Noto Color Emoji";
			};
		};
	};
}
