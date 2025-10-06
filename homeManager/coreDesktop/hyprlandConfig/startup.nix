{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {
		exec-once = [
			todoist-electron
			vesktop
		];
	};
}
