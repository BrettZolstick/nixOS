{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		emailScanner.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.emailScanner.enable {
		# Actual content of the module goes here:

			# This is an old powershell script that I wrote for my business

				# make a user and group for the service
				users = {
					users.emailScanner = {
						isSystemUser = true;
						home = "/srv/copyparty/prep/NewQA/EpcListEnhancer2";
						createHome = false;
						group = "emailScanner"; 
					};
					groups.emailScanner = {};
				};			
			
				systemd.services.emailScanner = {
					description = "Scans email for new epc lists";
					wantedBy = [ "multi-user.target" ];
					after = [ "network-online.target" ];
					wants = [ "network-online.target" ];
					serviceConfig = {
						Type = "simple";
						User = "emailScanner";
						WorkingDirectory = "/srv/copyparty/prep/NewQA/EpcListEnhancer2";
						EnvironmentFile = "/etc/emailscanner-imap-creds.env";
						ExecStart = "${pkgs.powershell}/bin/pwsh -File ./EmailScanner.ps1";
						Restart = "on-failure";
						RestartSec = 10;	
					};
				};			
			
		};	
	};		
}
