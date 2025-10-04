{ config, pkgs, lib, ... }: {

	wayland.windowManager.hyprland.settings = {
	
		# set variables
		"$mainMod"			=	"SUPER";
		"$terminal"			=	"kitty";
		"$browser"			=	"firefox";
		"$appLauncher"		=	"wofi";
		"$fileManager"		=	"dolphin";
		"$processViewer"	=	"btop";



		# keyboard binds
		bind = [

			# launch apps
			"$mainMod,			RETURN,	exec,	$terminal"
			"$mainMod,			SPACE, 	exec,	$appLauncher"
			"$mainMod,			DELETE,	exec,	$terminal $processViewer"
			"$mainMod,			B, 		exec,	$browser"
			"$mainMod,			E,		exec,	$fileManager"
			"$mainMod SHIFT,	S,		exec,	grimblast --freeze copy area"
			
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


	};
}
