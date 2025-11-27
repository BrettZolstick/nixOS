{ config, pkgs, lib, ... }: 
let 
	ethanRclone = pkgs.writeText "ethan-rclone.conf" ''
[copyparty]
type = webdav
url = https://files.cookiegroup.net
vendor = other
user = ethan
pass = (<* Run this once: sudo rclone --config=/etc/secrets/rclone-copyparty.conf config password copyparty pass <copypartyPassword>)

	'';
in
{

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		rcloneShares.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.rcloneShares.enable {
		# Actual content of the module goes here:

		environment.systemPackages = with pkgs; [ rclone ];

		systemd.tmpfiles.rules = [
			"d /etc/secrets 0774 root root - -"
			"C /etc/secrets/rclone-copyparty.conf 0660 root root - ${ethanRclone}"
			"f /etc/secrets/ethanCopyparty.pass 0660 root root - <password>"

		];

		fileSystems."/mnt/copyparty" = {
			device = "copyparty:/";
			fsType = "rclone";
			options = [
				"nodev"
				"nofail"
				"allow_other"
				"args2env"
				"config=/etc/secrets/rclone-copyparty.conf"
				"x-systemd.automount"
				"x-systemd.idle-timeout=600s"
				"x-systemd.after=network-online.target"
			];
		};
	};		
}
