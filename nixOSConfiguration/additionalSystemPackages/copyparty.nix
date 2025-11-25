{ config, pkgs, lib, copyparty, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		copyparty.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.copyparty.enable {
		# Actual content of the module goes here:

		nixpkgs.overlays = [ 
		
			copyparty.overlays.default

			# override to include optional dependencies
			(final: prev: {
				copyparty = prev.copyparty.overridePythonAttrs (old: {
				
					buildInputs = (old.buildInputs or []) ++ [prev.vips];

					propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ (with prev.python3Packages; [
						mutagen
						rawpy
						pillow-heif
						pyvips	
					]);	
					
				});	
			})
			
		];

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
			tunnels."b34be7c0-e420-4fa5-b7a1-2c36ca6a9c52" = {
				credentialsFile = "/home/ethan/.cloudflared/b34be7c0-e420-4fa5-b7a1-2c36ca6a9c52.json";
				ingress."files.cookiegroup.net" = "http://127.0.0.1:3923";
				default = "http_status:404";
			};
		};
		
		services.copyparty = {
			enable = true;		
			user = "copyparty";
			group = "copyparty";

			settings = {
				i = "127.0.0.1";
				p = [ 3923 ];
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
				};
				
				"/public" = {
					path = "/srv/copyparty/public";
					access = {
						A = "@owner";
						"rwmd." = "@admins";
						rw = "*";
					};
					flags = {
						vmaxb = "100g"; # volume cannot exceed <x>GiB
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
						A = "@owner";
						"rwmd." = "syncthing, @cookiegroup";
					};
				};

			};
		};
		
		# Optional dependencies needed at runtime 
		systemd.services.copyparty.path = lib.mkAfter [ 
			pkgs.cfssl # gives TLS certificates so that https can work properly
		];
		
		# Create template passwordFiles if they are not present.
		# 	- Change these externaly to whatever passwords you want 
		# 	- Copyparty has the user log in without a username (password only)
		#	  because of this, duplicate passwords are not supported. each
		#	  password must be unique
		systemd.tmpfiles.rules = [
			"d /etc/secrets 0660 root copyparty - -"
			"f /etc/secrets/ethanCopyparty.pass 0660 root copyparty - <password>"
			"f /etc/secrets/syncthingCopyparty.pass 0660 root copyparty - <password>"
		];		

	};	
}
