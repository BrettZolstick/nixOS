{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		template.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.template.enable {
		# Actual content of the module goes here:

		programs.git = {
			enable = true;
			userName = "Ethan"
			userEmail = "crazyeman83@gmail.com"	
		};	
			
	};	
}
