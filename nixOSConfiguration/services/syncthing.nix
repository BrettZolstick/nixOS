{ config, pkgs, lib, ... }: 
let

	hostname = config.networking.hostName;

	tmpfilesByHost = {
		ethanDesktop	= [ "d /srv/prep 0770 syncthing fileSharing" ];
		cg 				= [ "d /srv/prep 0770 syncthing fileSharing" ];
		ethanServer		= [ "d /srv/copyparty/prep 0770 syncthing fileSharing" ];

	};
	
	prepPathByHost = {
		ethanDesktop	= "/srv/prep";
		cg 				= "/srv/prep";
		ethanServer		= "/srv/copyparty/prep";

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

		
		# make user and group for service
		users.groups.fileSharing = {};
		

		services.syncthing = {
			enable = true;
			user = "syncthing";
			group = "fileSharing";
			openDefaultPorts = true; #22000-TCP (8384-TCP for web GUI)

			settings = {

				devices = {

					# to get device id, go to localhost:8384 in browser when syncthing service is running
					#
					# to get device id on remote machine, port forward with ssh and open using forwarded port in browser
					#	ssh -L 8385:localhost:8384 ethan@ethanServer
					# 	(localhost:8385 in browser)
					#
					"cg".id = "FCP4NII-2AIV3RI-IUTDHFM-REZJMQO-JIDQPBC-UXAOYKH-K5W5PPN-KEKHLQX";
					"ethanDesktop".id = "2YIZFBP-5P6R3QF-67KD5R7-VHEYSNQ-JKYZXXE-ERPTRYJ-B3CK4DD-ONAH5AC";
					"ethanServer".id = "WJHCPDV-DDZMORO-HYJHGCQ-MY3PZT3-73QBUD5-5NI3PHJ-2PKQCUV-YEPO4AD";
				};

				folders = {
					"prep" = {
						id = "prep";
						label = "prep";
						devices = [ "cg" "ethanServer" ];
						path = lib.attrByPath [ hostname ] "/srv/prep" prepPathByHost;
					};
				};
			};	
		};	

		systemd.tmpfiles.rules = lib.attrByPath [ hostname ] [ "d /srv/prep 0770 syncthing fileSharing" ] tmpfilesByHost;
		
	};		
	
}
