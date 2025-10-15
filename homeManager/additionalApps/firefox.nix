{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		firefox.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.firefox.enable {
		# Actual content of the module goes here:
		stylix.targets.firefox.profileNames = [
			"ethanPersonal"
		];

		programs.firefox = {
			enable = true;
			profiles.ethanPersonal = {
				settings = {
					"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
					"browser.fullscreen.autohide" = false;
					"browser.bookmarks.visibility" = "always";
					
				};
				userChrome = ''
@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
					
					
/* Make the bookmarks bar visible in fullscreen */
#PersonalToolbar:not([style*="pointer-events: none"]) {
	visibility: visible !important;
}
				'';
			};
		};
						
	};	
}
