{ config, pkgs, lib, ... }: {
	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		cifsShares.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.cifsShares.enable {
		# Actual content of the module goes here:

		boot.supportedFilesystems = [ "cifs" ];
		
		environment.systemPackages = with pkgs; [ cifs-utils ];
	
		fileSystems = {
			"/mnt/NetworkShare" = {
				device = "//192.168.68.63/Network Share";
				fsType = "cifs";
				options = [
					"credentials=/mnt/NetworkShare.creds" 
					# make a file at this path, formatted like this:
					# 	username=<username>
					#	password=<password>
					#	domain=<domain>   # optional
					#
					# then chmod 600 it 
					
					"uid=1000"                  
					"gid=100"                  
					"iocharset=utf8"
					"vers=3.0"                  
					"_netdev"                   	# don’t try before network
					"x-systemd.automount"       	# auto-mount on first access
					"noauto"                    	# with automount, prevents blocking boot
					"x-systemd.idle-timeout=600" 	# unmount after 10 min idle
				];
			};
			
			"/mnt/Prep" = {
				device = "//192.168.68.63/Prep";
				fsType = "cifs";
				options = [
					"credentials=/mnt/Prep.creds" 
					# make a file at this path, formatted like this:
					# 	username=<username>
					#	password=<password>
					#	domain=<domain>   # optional
					#
					# then chmod 600 it 
					
					"uid=1000"                  
					"gid=100"                  
					"iocharset=utf8"
					"vers=3.0"                  
					"_netdev"                   	# don’t try before network
					"x-systemd.automount"       	# auto-mount on first access
					"noauto"                    	# with automount, prevents blocking boot
					"x-systemd.idle-timeout=600" 	# unmount after 10 min idle
				];
			};
		};	
	};		
}
