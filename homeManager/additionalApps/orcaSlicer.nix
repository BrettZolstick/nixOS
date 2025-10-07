{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		orcaSlicer.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.orcaSlicer.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ orca-slicer ];		
	};	
}
