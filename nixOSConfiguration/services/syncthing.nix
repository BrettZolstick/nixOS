{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		rcloneShares.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.rcloneShares.enable {
		# Actual content of the module goes here:

		services.syncthing = {
			enable = true;
			user = "syncthing";
			group = "syncthing";
			openDefaultPorts = true; #22000-TCP (8384-TCP for web GUI)
			
		};
		
	};		
}
