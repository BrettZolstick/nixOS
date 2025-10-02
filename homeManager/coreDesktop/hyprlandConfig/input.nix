{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {

		input = {
			# keyboard
			#kb_model 				= ; 
			kb_layout 				= "us";
			#kb_variant 			= ; 
			#kb_options 			= ;
			#kb_rules 				= ;
			#kb_file 				= ; 
			numlock_by_default		= false;
			resolve_binds_by_sym	= false;
			repeat_rate 			= 40;
			repeat_delay 			= 200;

			# mouse
			sensitivity 			= 0;
			accel_profile 			= "flat";
			force_no_accel 			= true;
			left_handed 			= false;
			#scroll_points 			= ;
			#scroll_method 			= ;
			scroll_button 			= 0;
			scroll_button_lock 		= 0;
			scroll_factor 			= 1;
			natural_scroll 			= false;
			emulate_discrete_scroll = 0;

			# window interactions
			follow_mouse 					= 1; # (see comment below)
			follow_mouse_threshold 			= 0;
			focus_on_close 					= 1;
			mouse_refocus 					= true;
			float_switch_override_focus 	= 1;
			special_fallthrough 			= false;
			off_window_axis_events 			= 1;

			######### Follow Mouse Options #########		
			#
			#    0 - Cursor movement does not change window focus
			#    1 - Cursor movement will always change the focus to the window under the cursor (Hyprland default)
			#    2 - Cursor focus is detached from keyboard focus. Clicking on a window moves keyboard focus to that window (Windows default)
			#    3 - Cursor focus will be separate from keyboard focus, clicking on a window will not change keyboard focus.
			#               
			########################################
			
			
		};
		
	};
}
