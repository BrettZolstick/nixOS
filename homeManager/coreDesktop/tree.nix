{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		tree.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.tree.enable {
		# Actual content of the module goes here:

       	home.packages = with pkgs; [ tree ];
		
	};	
}
