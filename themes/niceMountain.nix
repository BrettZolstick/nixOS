{ config, lib, stylix, pkgs, ...}: {

	# Colors
	stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";

	# Wallpaper
	stylix.image = ./wallpapers/niceMountain.png;

	# Cursors
	#stylix.cursor.package = pkgs.nordzy-cursor-theme;
	#stylix.cursor.name = "Nordzy-cursors";
			  	
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
