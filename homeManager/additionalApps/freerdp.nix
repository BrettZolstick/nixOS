{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		freerdp.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.freerdp.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ freerdp ];	

		xdg.desktopEntries."Ethan-Server" = {
			name = "Ethan Server (RDP)";
			exec = "${pkgs.freerdp}/bin/xfreerdp /v:192.168.68.63 /u:servertron9000 /p:./freerdp-servetron9000.pass /cert:ignore /f /rfx /clipboard";
			terminal = false;
			icon = "computer";
		};
		
	};	
}
