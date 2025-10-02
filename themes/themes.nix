{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		desktopThemes.themeName = lib.mkOption {
			default = "gaucho";
			description = "selects which theme to enable"	
		};
	};
	
	config = lib.mkMerge [
	
		(lib.mkIf (config.desktopThemes.themeName == "default" ) {
			# Actual content of the module goes here:
			desktopThemes.gaucho.enable = true;
				
		})	
	];

		
}
