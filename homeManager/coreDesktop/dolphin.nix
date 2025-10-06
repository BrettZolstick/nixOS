{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		dolphin.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.dolphin.enable {
		# Actual content of the module goes here:

		home.packages = with pkgs; [

			kdePackages.dolphin		# actual dolphin package
			kdePackages.kio-fuse 	# for mounting network shares
			kdePackages.kio-extras	# extra protocols for mounting network shares
			kdePackages.qtsvg		# enables svg icons
			
		];
		
		
	};	
}
