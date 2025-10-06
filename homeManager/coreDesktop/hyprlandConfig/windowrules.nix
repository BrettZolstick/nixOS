{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {
		windowrule = [
			# Ignore maximize requests from apps.
			"suppressevent maximize, class:*"

			# Fix some dragging issues with XWayland
			"nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"

			# disable transparency for videos
			"opacity 1.2, content:video"

			# disable transparency for firefox
			"opacity 1.2, class:firefox"

			# disable transparency for discord
			"opacity 1.2, class:vesktop"
			"opacity 1.2, class:discord"
			

			# disable hyprland transparency for kitty (so it doesn't stack with kitty's built in transparency)
			#"opacity 99 1, class:kitty" # leaving this commented out because I kinda like the stacked transparency

			# enable tearing for osu!
			"immediate, class: osu!"

			# Wofi 
			"float, class:wofi"
			"rounding 10, class:wofi"
			#"roundingpower 1, class:wofi"
			"bordersize 4, class:wofi"

			# Open discord and todoist in workspace 2
			"workspace 2, class: vesktop"
			"workspace 2, class: Todoist"

			# Open steam games in fullscreen on DP-1
			"workspace 1, class: ^(steam_app_.*)$"
			"fullscreen , class: ^(steam_app_.*)$"
		];	
	};
}
