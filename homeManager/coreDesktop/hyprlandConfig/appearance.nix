{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {
		general = {
			# borders
			border_size 			= 2;
			no_border_on_floating	= false;

			# gaps
			gaps_in 		= 2;
			gaps_out 		= 2;
			gaps_workspaces	= 0;	
		};

		decoration = {
			# rounding
			rounding 				= 4;	# rounded corners’ radius (in layout px)
			rounding_power			= 2;	# adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner.

			# opacity
			active_opacity			= 1;	# opacity of active windows.
			inactive_opacity		= 0.9;	# opacity of inactive windows.
			fullscreen_opacity		= 1;	# opacity of fullscreen windows.

			# dimming
			dim_modal				= true;		# enables dimming of parents of modal windows
			dim_inactive			= false;	# enables dimming of inactive windows
			dim_strength			= 0.2;		# how much inactive windows should be dimmed
			dim_special				= 0.2;		# how much to dim the rest of the screen by when a special workspace is open.
			dim_around				= 0.4;		# how much the dimaround window rule should dim by.

			# other
			#screen_shader			= 		# a path to a custom shader to be applied at the end of rendering. See examples/screenShader.frag for an example.
			border_part_of_window	= true;	# whether the window border should be a part of the window

			# blur
			
		};
	};
}
