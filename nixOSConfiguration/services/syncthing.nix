{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		syncthing.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.syncthing.enable {
		# Actual content of the module goes here:

		services.syncthing = {
			enable = true;
			user = "syncthing";
			group = "syncthing";
			openDefaultPorts = true; #22000-TCP (8384-TCP for web GUI)

			settings = {

				devices = {
					"cg".id = "FCP4NII-2AIV3RI-IUTDHFM-REZJMQO-JIDQPBC-UXAOYKH-K5W5PPN-KEKHLQX";
				};

				folders = {
					"prep" = {
						id = "prep";
						label = "prep";
						devices = [ "cg" ];
						path =
							if config.networking.hostName == "ethanServer"
							then "/srv/prep"
							else "/srv/prep";
					};
				};
			};	
		};	

		config = lib.mkIf ( config.networking.hostName == "ethanDesktop" ) {
			systemd.tmpfiles.rules = [
			"d /srv/prep 0750 syncthing syncthing -"
		  	];
		};
	};		
}
