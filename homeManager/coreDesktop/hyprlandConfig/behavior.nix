{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {
		general = {
			# Behavior
			layout 						= "dwindle"; 	# which layout to use. [dwindle/master]
			no_focus_fallback 			= false;		# if true, will not fall back to the next available window when moving focus in a direction where no window was found
			resize_on_border			= true;			# enables resizing windows by clicking and dragging on borders and gaps
			extend_border_grab_area 	= 15;			# the area around the border that triggers click and drag resize (only if resize_on_Border is true)
			hover_icon_on_border		= true;			# show a special cursor icon when hovering on a border
			allow_tearing				= true; 		# master switch to allow screen tearing for lower latency in games (window rules must be used to specify a target like so "windowrule = immediate, class:^(cs2)$")
			resize_corner 				= 0;				# force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)
			snap = {
				enabled 		= false; 	# enable snapping for floating windows
				window_gap		= 10;		# minimum gap in pixels between windows before snapping
				monitor_gap		= 10;		# minimum gap in pixels between window and monitor edges before snapping
				border_overlap	= false;	# if true, windows snap such that only one border’s worth of space is between them
				respect_gaps	= false;	# if true, snapping will respect gaps between windows(set in general:gaps_in)
			};

			ecosystem.no_update_news = true; # disable hyprland support message
			
		};	
	};
}
