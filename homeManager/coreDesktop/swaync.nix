{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    swaync.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.swaync.enable {
    # Actual content of the module goes here:

    #services.playerctld.enable = true; # install playerctl so that swaync can see what music is playing

    services.swaync = {
      enable = true;
      settings = {
        # for all configuration options, see: https://man.archlinux.org/man/swaync.5.en

        # Main settings
        ignore-gtk-theme = true; #Unsets the GTK_THEME environment variable, fixing a lot of issues with GTK themes ruining the users custom CSS themes.
        positionX = "right";
        positionY = "top";
        layer = "overlay"; #Layer of notification window relative to normal windows. background is below all windows, overlay is above all windows.
        layer-shell = true; # Whether or not the windows should be opened as layer-shell surfaces. Note: Requires swaync restart to apply
        cssPriority = "application"; # Which GTK priority to use when loading the default and user CSS files. Pick "user" to override XDG_CONFIG_HOME/gtk-3.0/gtk.css
        image-visibility = "always"; # values: always, when-available, never

        # Notifications
        timeout = 6; # The notification timeout for notifications with normal priority
        timeout-low = 3; # The notification timeout for notifications with low priority
        timeout-critical = 0; # The notification timeout for notifications with critical priority. 0 to disable
        notification-2fa-action = true; # If each notification should display a 'COPY "1234"' action
        notification-window-width = 500; # Width of the notification in pixels
        notification-window-height = 1000; # Max height of the notification in pixels. -1 to use the full amount of space given by the compositor.
        notification-window-preferred-output = ""; # The preferred output to open the notification window (popup notifications). Can either be the monitor connector name (ex: "DP-1"), or the full name, manufacturer model serial (ex: "Acer Technologies XV272U V 503023B314202"). If the output is not found, the currently focused one is picked.
        notification-grouping = false; # If notifications should be grouped by app name
        transition-time = 200; # The notification animation duration. 0 to disable

        # Control Center
        control-center-margin-top = 20; # The margin (in pixels) at the top of the notification center. 0 to disable
        control-center-margin-bottom = 400; # The margin (in pixels) at the bottom of the notification center. 0 to disable
        control-center-margin-right = 20; # The margin (in pixels) at the right of the notification center. 0 to disable
        control-center-margin-left = 0; # The margin (in pixels) at the left of the notification center. 0 to disable
        control-center-layer = "overlay"; # Layer of control center window relative to normal windows. background is below all windows, overlay is above all windows.
        control-center-exclusive-zone = true; # Whether or not the control center should follow the compositors exclusive zones. An example would be setting it to false to cover your panel/dock
        keyboard-shortcuts = true; # If control center should use keyboard shortcuts
        hide-on-clear = false; # Hides the control center after pressing "Clear All"
        hide-on-action = true; # Hides the control center when clicking on notification action
        text-empty = ""; # Text that appears when there are no notifications to show
        fit-to-screen = false; # Whether the control center should expand vertically to fill the screen
        relative-timestamps = true; # Display notification timestamps relative to now e.g. "26 minutes ago". If false, a local iso8601-formatted absolute timestamp is displayed.
        control-center-height = 1000; # Height of the control center in pixels. A value of -1 means that it will fit to the content. Ignored when 'fit-to-screen' is set to 'true'. Also limited to the height of the monitor, unless 'layer-shell-cover-screen' is set to false.
        control-center-width = 500; # The control center width in pixels
        control-center-preferred-output = ""; # The preferred output to open the control center. Can either be the monitor connector name (ex: "DP-1"), or the full name, manufacturer model serial (ex: "Acer Technologies XV272U V 503023B314202"). If the output is not found, the currently focused one is picked.

        # Set the visibility or override urgency of each incoming notification.
        # If the notification doesn't include one of the properties, that
        # property will be ignored. All properties (except for state) use
        # regex. If all properties match the given notification, the
        # notification will be follow the provided state.
        #
        #
        #notification-visibility = {
        #	example-name = {
        #		state 				= "enabled"; 	# The notification visibility state.
        #		#override-urgency 	= "unset"; 		# The new urgency for the notification if set.
        #		#app-name 			= ""; 			# The app-name. Uses Regex.
        #		#desktop-entry 		= ""; 			# The desktop-entry. Uses Regex.
        #		#summary 			= ""; 			# The summary of the notification. Uses Regex.
        #		#body 				= ""; 			# The body of the notification. Uses Regex.
        #		#urgency 			= ""; 			# The urgency of the notification.
        #		#category 			= ""; 			# Which category the notification belongs to. Uses Regex.
        #	};
        #};

        widgets = [
          "mpris"
          "title"
          "dnd"
          "notifications"
        ];

        widget-config = {
          title = {
            text = "Notifications";
            clear-all-button = true;
            button-text = "Clear All";
          };

          dnd = {
            text = "Do Not Disturb";
          };

          mpris = {
            blacklist = [];
            autohide = true;
            show-album-art = "when-available";
            loop-carousel = true;
          };
        };
      };
    };
  };
}
