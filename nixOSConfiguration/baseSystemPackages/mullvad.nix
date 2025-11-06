{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		mullvad.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.mullvad.enable {
		# Actual content of the module goes here:

		services.mullvad-vpn.enable = true;
		services.mullvad-vpn.package = pkgs.mullvad-vpn;

	};		



}
