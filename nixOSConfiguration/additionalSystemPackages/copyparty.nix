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
			tunnels."2d8c3263-406b-4ce6-b7f0-244857faaa15" = {
				credentialsFile = "/home/ethan/.cloudflared/2d8c3263-406b-4ce6-b7f0-244857faaa15.json";
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
				p = [ 3923 ];		# port(s)
				"xff-hdr" = "cf-connecting-ip"; # get client IPs connecting from cloudflare
			};

			accounts = {
				# Set passwords at /etc/secrets/
				ethan.passwordFile = "/etc/secrets/ethanCopyparty.pass";
				syncthing.passwordFile = "/etc/secrets/syncthingCopyparty.pass";
			};

			groups = {
				admins = [
					"ethan"
				];
			};
			
			volumes = {
				"/public" = {
					path = "/srv/copyparty/public";
					access = {
						rw = "*";
						A = "@admins";
					};					
				};

				"/ethan" = {
					path = "/srv/copyparty/ethan";
					access = {
						A = "ethan";
					};
				};

				"/prep" = {
					path = "/srv/copyparty/prep";
					access = {
						rwmd = "syncthing";
						A = "@admins";
					};
				};

			};
		};

		# Create template passwordFiles if they are not present.
		systemd.tmpfiles.rules = [
			"d /etc/secrets 0770 root copyparty - -"
			"f /etc/secrets/ethanCopyparty.pass 0660 root copyparty - <password>"
			"f /etc/secrets/syncthingCopyparty.pass 0660 root copyparty - <password>"
		];		

	};	
}
