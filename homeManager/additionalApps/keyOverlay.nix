{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		keyOverlay.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.keyOverlay.enable {
		# Actual content of the module goes here:


		# This is a dirty way of doing this and is not self contained or easily reproducable. But im leaving this for now.
		# I'd like to come back to this and make this purely declarative, or maybe even contribute keyoverlay to nixpkgs.
		xdg.desktopEntries."KeyOverlay" = {
			name = "Key Overlay";

			# This is the dirty part. (need to clone the KeyOverlay repo into home manually, and then make a flake for it)
			# This desktop entry only builds the flake.
			exec = "nix develop ~/KeyOverlay/ --command dotnet run --project /home/ethan/KeyOverlay/KeyOverlay -c Release";
			comment = "An overlay that shows key press history";
			terminal = false;
			startupNotify = true;
		};	
	};	
}
