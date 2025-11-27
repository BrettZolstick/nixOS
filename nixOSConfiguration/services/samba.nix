{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		samba.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.samba.enable {
		# Actual content of the module goes here:

		services.samba = {
			enable = true;
			openFirewall = true;
			settings = {
				global = {
					"workgroup" = "WORKGROUP";
					"server string" = "CookieGroup NixOS Samba Server";
					"netbios name" = "cg";
					"security" = "user";
					"hosts allow" = "10.0.0. 127.0.0.1 localhost"; # allows traffic on LAN and localhost (10.0.0. subnet) 
					"hosts deny" = "0.0.0.0/0"; # denies all traffic, excluing what is set in "host allow"
					"guest account" = "nobody";
					"map to guest" = "bad user";	
				};
				"p" = {
					"path" = "/mnt/copyparty/prep";
					"browseable" = "yes";
					"read only" = "no";						
					"guest ok" = "no";
					"create mask" = "0777";						
					"directory mask" = "0777";
					"valid users" = "administrator";
					"force user" = "administrator";
					#"force user" = "nobody";
					#"force group" = "nogroup";
				};
			};
		};

		# Make unix users on the local system
		#
		# This allows for the windows users to authenticate automatically 
		# with no user input if their credentials are the same
		#
		# When adding a new user, be sure give the user a samba password
		# > sudo smbpasswd -a <user>
		users.users = {
		
			administrator = {
				isSystemUser = true;
				description = "Samba user for windows users named 'administrators'";
				home = "/var/empty";
				createHome = false;
				group = "users";
				shell = "${pkgs.shadow}/bin/nologin";
				
			};
			
			admin = {
				isSystemUser = true;
				description = "Samba user for windows users named 'admin'";
				home = "/var/empty";
				createHome = false;
				group = "users";
				shell = "${pkgs.shadow}/bin/nologin";

			};	
		};

		# Allows the share to be able to be found under the network tab in Windows
		services.samba-wsdd = {
			enable = true;
			openFirewall = true;
		};
	};	
}
