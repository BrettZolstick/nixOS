{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		missionCenter.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.missionCenter.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ mission-center ];		
	};	
}
