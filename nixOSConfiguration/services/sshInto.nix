{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		sshInto.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.sshInto.enable {
		# Actual content of the module goes here:

		# enable ssh
		services.openssh = {
			enable = true;
			ports = [ 22 ];
			settings = {
				PasswordAuthentication = false;
				PubkeyAuthentication = true;
				PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
			};
		};
		
			
	};	
}
