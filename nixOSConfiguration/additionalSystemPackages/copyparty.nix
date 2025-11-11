{ config, pkgs, lib, copyparty, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		copyparty.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.copyparty.enable {
		# Actual content of the module goes here:

		nixpkgs.overlays = [ copyparty.overlays.default ];

		environment.systemPackages = with pkgs; [ copyparty ];

		services.copyparty = {
			enable = true;		
			user = "copyparty"; 	# The user to run the service as
			group = "copyparty";	# The group to run the service as

			settings = {
				i = "0.0.0.0"; 	# IP
				p = [ 3210 ];	# port(s)
			};

			volumes = {
				"/" = {
					path = "/srv/copyparty";
					access = {
						r = "*";
					};
				};
			};
		};		

	};	
}
