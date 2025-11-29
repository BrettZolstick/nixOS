{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		minecraftGTNHServer.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.minecraftGTNHServer.enable {
		# Actual content of the module goes here:

		users.users.minecraftGTNH = {
			isSystemUser = true;
			home = "/srv/minecraftGTNHServer";
			createHome = false;
		};

		environment.systemPackages = with pkgs; [
			 pkgs.javaPackages.compiler.temurin-bin.jre-25
		];

		networking.firewall.allowedTCPPorts = [ 25565 ];


	};	
}
