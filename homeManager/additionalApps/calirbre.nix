{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		calibre.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.calibre.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ 
			calibre
		];		
	};	
}
