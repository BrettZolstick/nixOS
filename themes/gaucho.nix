{ config, lib, stylix, pkgs, ...}: {

	# Colors
	stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/brewer.yaml";

	# Wallpaper
	stylix.image = ./wallpapers/culprate-gaucho.jpg;

	# Cursors
	stylix.cursor.package = pkgs.nordzy-cursor-theme;
	stylix.cursor.name = "Nordzy-hyprcursors";

	# Fonts	
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

}
