{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		kitty.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.kitty.enable {
		# Actual content of the module goes here:

       	programs.kitty = {
       		enable = true;

       		enableGitIntegration = true;
       		font.size			 = 12;

       		# shells
    		shellIntegration.enableBashIntegration = true;
       		shellIntegration.enableFishIntegration = true;
       		shellIntegration.enableZshIntegration = true;


			settings = {
				background_opacity = lib.mkForce 0.75;
				background_blur = 32;
			
				scrollback_lines = 10000;
				enable_audio_bell = false;
				tab_width 			= 4;
				wheel_scroll_multiplier = 5;
				sync_to_monitor = "yes";
				confirm_os_window_close = 0;
				
			};
       		# Background
			#background_opacity	= 0.75;
			#background_blur 	= 32;

			# Font
			#font_family 		= "JetBrains Mono Nerd Font";
			#bold_font			= "auto";
			#italic_font			= "auto";
			#bold_italic_font	= "auto";
			#font_size			= 12;

			# Behavior
			#tab_width 					= 4;
			#wheel_scroll_multiplier 	= 5;
			#sync_to_monitor 			= "yes";		
			#confirm_os_window_close 	= 0;

			# extra
#			extraConfig 	=''
#				background_opacity 	0.2
#				background_blur 	32
#
#				tab_width 					4
#				wheel_scroll_multiplier 	5
#				sync_to_monitor 			yes		
#				confirm_os_window_close 	0
#			'';      		
       	};
       			
	};	
}
