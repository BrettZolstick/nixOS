{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		osu-lazer.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.osu-lazer.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ osu-lazer-bin ];	

		xdg.desktopEntries."osu!" = {
			name = "osu!";
			exec = "env PIPEWIRE_LATENCY=128/48000 PIPEWIRE_QUANTUM=128/48000 osu!";
			icon = "osu";
			comment = "A free-to-win rhythm game. Rhythm is just a *click* away!";
			terminal = false;
			mimeType = [
				"application/x-osu-beatmap-archive"
				"application/x-osu-skin-archive"
				"application/x-osu-beatmap"
				"application/x-osu-storyboard"
				"application/x-osu-replay"
				"x-scheme-handler/osu"
			];
			categories = [ "Game" ];
			startupNotify = true;
		};	
	};	
}
