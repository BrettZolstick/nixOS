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

		environment.systemPackages = with pkgs; [ 
			copyparty
			cloudflared
		];

		services.cloudflared = {
			enable = true;

			# create a tunnel
			#	❯ cloudflared tunnel login
			#	❯ cloudflared tunnel create <name>
			# 	❯ cloudflared tunnel route dns <name> files.yourdomain.com
			tunnels."03d4872e-4766-46dd-9869-750ce18d97c3" = {
				credentialsFile = "/home/ethan/.cloudflared/03d4872e-4766-46dd-9869-750ce18d97c3.json";
				ingress."files.cookiegroup.net" = "http://127.0.0.1:3923";
				default = "http_status:404";
			};
		};
		

		services.copyparty = {
			enable = true;		
			user = "copyparty"; 	# The user to run the service as
			group = "copyparty";	# The group to run the service as

			settings = {
				i = "127.0.0.1"; 	# IP
				p = [ 3923 ];	# port(s)
				"xff-hdr" = "cf-connecting-ip"; # get client IPs connecting from cloudflare
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
