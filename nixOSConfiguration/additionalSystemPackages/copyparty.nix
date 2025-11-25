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
			cfssl
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
				"xff-src" = "127.0.0.1";
				rproxy = 1;

				# global flags
				e2dsa = true; # enable indexing of all files (enables cool things like de-duplication, file lifetime, etc...)
				e2ts = true; # enables media tags (change to e2tsr to reindex everything if you want that for some reason)
				df = "100g"; # minimum free disk space
			};

			accounts = {
				# Set passwords at /etc/secrets/
				ethan.passwordFile = "/etc/secrets/ethanCopyparty.pass";
				syncthing.passwordFile = "/etc/secrets/syncthingCopyparty.pass";
			};

			groups = {
			
				owner = [
					"ethan"
				];

				admins = [
					"ethan"
				];

				cookiegroup = [
					"ethan"
				];
				
			};
			
			volumes = {

				"/" = {
					path = "/srv/copyparty/";
					access = {
						A = "@owner";
						"rwmd." = "@admins";
					};
					flags = {
						df = "100g"; # free disk space cannot go lower than this 
					};
				};
				
				"/public" = {
					path = "/srv/copyparty/public";
					access = {
						A = "@owner";
						"rwmd." = "@admins";
						rw = "*";
					};
					flags = {
						#vmaxb = "100g"; # volume cannot exceed <x>GiB
						lifetime = 10; # deletes files after 10 seconds
						#dedup = false;
						#sz="0b-1b";
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
						"rwmd." = "syncthing, @cookiegroup";
						A = "@owner";
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
