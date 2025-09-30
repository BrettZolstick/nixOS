{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		hyprland.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.hyprland.enable {
		# Actual content of the module goes here:

		wayland.windowManager.hyprland.enable = true;
		wayland.windowManager.hyprland.settings = {

			"$mainMod"			=	"SUPER";
			"$terminal"			=	"kitty";
			"$browser"			=	"firefox";
			"$appLauncher"		=	"wofi";
			"$fileManager"		=	"dolphin";
			"$processViewer"	=	"btop";

			# keyboard binds
			bind = [
			
				# launch apps
				"$mainMod,	RETURN,	exec,	$terminal"
				"$mainMod,	SPACE, 	exec,	$appLauncher"
				"$mainMod,	DEL,	exec,	$processViewer"
				"$mainMod,	B, 		exec,	$browser"
				"$mainMod,	E,		exec,	$fileManager"
				
				# window actions
				"$mainMod,	Q,	killactive"		
				"$mainMod,	T,	toggleFloating"	
				"$mainMod,	F,	fullscreen"		

				# move focus with mainMod + arrow keys
				"$mainMod,	LEFT,	movefocus,	l"
				"$mainMod,	RIGHT,	movefocus,	r"
				"$mainMod,	UP,		movefocus,	u"
				"$mainMod,	DOWN,	movefocus,	d"

				# switch workspace with mainMod + [1-9]
				"$mainMod,	1,	workspace,	1"
				"$mainMod,	2,	workspace,	2"
				"$mainMod,	3,	workspace,	3"
				"$mainMod,	4,	workspace,	4"
				"$mainMod,	5,	workspace,	5"
				"$mainMod,	6,	workspace,	6"
				"$mainMod,	7,	workspace,	7"
				"$mainMod,	8,	workspace,	8"
				"$mainMod,	9,	workspace,	9"
				"$mainMod,	0,	workspace,	10"

				# move active window to a workspace with mainMod + [0-9]
				"$mainMod SHIFT,	1,	movetoworkspace,	1"
				"$mainMod SHIFT,	2,	movetoworkspace,	2"
				"$mainMod SHIFT,	3,	movetoworkspace,	3"
				"$mainMod SHIFT,	4,	movetoworkspace,	4"
				"$mainMod SHIFT,	5,	movetoworkspace,	5"
				"$mainMod SHIFT,	6,	movetoworkspace,	6"
				"$mainMod SHIFT,	7,	movetoworkspace,	7"
				"$mainMod SHIFT,	8,	movetoworkspace,	8"
				"$mainMod SHIFT,	9,	movetoworkspace,	9"
				"$mainMod SHIFT,	0,	movetoworkspace,	10"
				 
			];

			# mouse binds
			bindm = [
				# move/resize windows with left/right click + drag
				"$mainMod,	mouse:272, movewindow"		# move windows with left mouse button drag 
				"$mainMod,	mouse:273, resizewindow"	# resize windows with right mouse button drag			
			];



			# monitors and workspaces
			monitor = [
				"DP-1,		2560x1440@239.97,	1920x0,	1"
				"DP-2,		1920x1080@60.00,	6400x0,	1"
				"DP-3,		1920x1080@60.00,	0x0,	1"
				"HDMI-A-1,	1920x1080@60.00,	4480x0,	1"
			];

			workspace = [
				"1,	monitor:DP-1,		default:true"
				"2,	monitor:DP-3,		default:true"
				"3,	monitor:HDMI-A-1,	default:true"
				"4,	monitor:DP-2,		default:true"
			];
			
		};
				
	};	
}
