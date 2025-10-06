{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		yazi.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.yazi.enable {
		# Actual content of the module goes here:

		programs.yazi = {
			enable = true;
			enableFishIntegration = true;
			settings = {
				# view options here: https://yazi-rs.github.io/docs/configuration/yazi
				manager = {
					ratio = [1 2 5]; # Manager layout by ratio
					sort_by = "natural"; # File sorting method.
					sort_sensitive = false; # Sort case-sensitively.
					sort_reverse = false; # Display files in reverse order.#
					sort_dir_first = true; # Display directories first.
					sort_translit = true; # This is useful for files that contain Hungarian characters.
					linemode = "size"; # Line mode: display information associated with the file on the right side of the file list row.
					show_hidden = false; # Show hidden files.
					show_symlink = true; # Show the path of the symlink file point to, after the filename.
					scrolloff = 20; # The number of files to keep above and below the cursor when moving through the file list.
					#mouse_events = []; # leaving this default until I have a reason to change it
					title_format = "Yazi => {cwd}"; # The terminal title format, which is a string with the following placeholders available:
					
				};				
			};	
		};

	};	
}
