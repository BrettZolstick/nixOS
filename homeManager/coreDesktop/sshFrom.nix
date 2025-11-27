{ config, pkgs, lib, ... }:
let
	keysWithPasswords = [ 
		"~/.ssh/sshFromEthanDesktop-id_ed25519"
		"~/.ssh/sshFromEthanLaptop-id_ed25519"
		"~/.ssh/sshFromEthanServer-id_ed25519"
		"~/.ssh/sshFromCG-id_ed25519"
	];
in
{
	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		sshFrom.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.sshFrom.enable {
		# Actual content of the module goes here

       	programs.ssh = {
       		enable = true;
       		enableDefaultConfig = false;

       		matchBlocks = {
       			"ethanServer" = {
       				hostname = "192.168.68.67";
       				user = "ethan";
       				identityFile = keysWithPasswords;
       				identitiesOnly = true;
       			};
       			"ethanDesktop" = {
       				hostname = "192.168.68.53";
       				user = "ethan";
       				identityFile = keysWithPasswords;
       				identitiesOnly = true;
       			};
       			"ethanLaptop" = {
       				hostname = "192.168.68.69";
       				user = "ethan";
       				identityFile = keysWithPasswords;
       				identitiesOnly = true;
       			};
       			# "cg" = {
       			# 	hostname = "192.168.68.67";
       			# 	user = "ethan";
       			# 	identityFile = keysWithPasswords;
       			# 	identitiesOnly = true;
       			# };
       		};
       	};
		
	};	
}
