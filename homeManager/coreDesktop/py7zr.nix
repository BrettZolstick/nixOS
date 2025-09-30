{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		py7zr.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.py7zr.enable {
		# Actual content of the module goes here:

		home.packages = with pkgs; [ py7zr ];
				
	};	
}
