{ config, pkgs, lib, ... }: 
let

	hostname = config.networking.hostName;

	tmpfilesByHost = {
		ethanDesktop	= [ "d /srv/prep 0770 syncthing syncthing" ];
		cg 				= [ "d /srv/prep 0770 syncthing syncthing" ];
	};
	
	prepPathByHost = {
		ethanDesktop	= "/srv/prep";
		cg 				= "/srv/prep";

	};
	
in
{

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
					"ethanDesktop".id = "2YIZFBP-5P6R3QF-67KD5R7-VHEYSNQ-JKYZXXE-ERPTRYJ-B3CK4DD-ONAH5AC";
				};

				folders = {
					"prep" = {
						id = "prep";
						label = "prep";
						devices = [ "cg" ];
						path = lib.attrByPath [ hostname ] "/srv/prep" prepPathByHost;
					};
				};
			};	
		};	

		systemd.tmpfiles.rules = lib.attrByPath [ hostname ] [ "d /srv/prep 0770 syncthing syncthing" ] tmpfilesByHost;
		
	};		
}
