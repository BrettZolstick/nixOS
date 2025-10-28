{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		dotnet.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.dotnet.enable {
		# Actual content of the module goes here:
		
       	home.packages = with pkgs; [ dotnet-runtime ];
		
	};	
}
