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

		# Allows the share to be able to be found under the network tab in Windows
		services.samba-wsdd = {
			enable = true;
			openFirewall = true;
		};
	};	
}
