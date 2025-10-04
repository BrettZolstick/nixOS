{ config, pkgs, lib, stylix, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		vesktop.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.vesktop.enable {
		# Actual content of the module goes here:


			programs.vesktop = {
				enable = true;

				settings = {
					enableSplashScreen = false;
					tray = true;
					minimizeToTray = true;
				};
			};

			stylix.targets.vesktop.enable = false;

			xdg.desktopEntries.vesktop = {
				categories 		= [ "Network" "InstantMessaging" "Chat" ];
				exec 			= "vesktop %U";
				genericName		= "Internet Messenger";
				icon			= "${pkgs.discord}/share/pixmaps/discord.png";
				name			= "Discord (Vesktop)";
				type			= "Application";
			};
				
	};	
}
