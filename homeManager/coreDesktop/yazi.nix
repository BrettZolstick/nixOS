{
  config,
  lib,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
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
        mgr = {
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
      theme = lib.mkForce {
        mgr = {
          cwd = {
            fg = colors.base05;
            bg = colors.base00;
            bold = true;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          hovered = {
            fg = colors.base00;
            bg = colors.base04;
            bold = true;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          preview_hovered = {
            #fg 			= colors.base04;
            #bg 			= colors.base00;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          find_keyword = {
            fg = colors.base05;
            bg = colors.base01;
            bold = true;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          marker_copied = {
            fg = colors.base0A;
            bg = colors.base0A;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          marker_cut = {
            fg = colors.base08;
            bg = colors.base08;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          marker_marked = {
            fg = colors.base0C;
            bg = colors.base0C;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          marker_selected = {
            fg = colors.base0C;
            bg = colors.base0C;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          count_copied = {
            fg = colors.base00;
            bg = colors.base0B;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          count_cut = {
            fg = colors.base00;
            bg = colors.base08;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          count_selected = {
            fg = colors.base00;
            bg = colors.base0C;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          border_symbol = "│";
          border_style = {
            fg = colors.base02;
            bg = colors.base00;
            bold = false;
            dim = false;
            italic = false;
            underline = false;
            blink = false;
            blink_rapid = false;
            reversed = false;
            hidden = false;
            crossed = false;
          };
          #syntect_theme = "./example.tmTheme"; # syntax color theme in previews
        };
        filetype = {
          rules = [
            {
              name = "*/";
              fg = colors.base0A;
              dim = false;
            }
            {
              name = "*";
              fg = colors.base04;
            }
          ];
        };
      };
    };
  };
}
