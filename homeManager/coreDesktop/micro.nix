{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		micro.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.micro.enable {
		# Actual content of the module goes here:

       	programs.micro.enable = true;
       	programs.micro.settings = {

			# configuration options can be found here: 
			# https://github.com/zyedidia/micro/blob/master/runtime/help/options.md	
       	};
	};	
}
