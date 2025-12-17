{
  config,
  pkgs,
  lib,
  stylix,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    wofi.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.wofi.enable {
    # Actual content of the module goes here:

    # hide unwanted desktop entries
    xdg.desktopEntries = {
      fish = {
        name = "fish";
        noDisplay = true;
      };

      qt5ct = {
        name = "Qt5 Settings";
        noDisplay = true;
      };

      qt6ct = {
        name = "Qt6 Settings";
        noDisplay = true;
      };

      nixos-manual = {
        name = "NixOS Manual";
        noDisplay = true;
      };

      kvantummanager = {
        name = "Kvantum Manager";
        noDisplay = true;
      };

      micro = {
        name = "Micro";
        noDisplay = true;
      };
    };

    programs.wofi = {
      enable = true;

      settings = {
        # behavior
        mode = "drun";
        term = "kitty";
        exec-search = false;
        matching = "contains";
        insensitive = true;
        sort_order = "default";
        filter_rate = 1;
        single_click = false;

        # appearance
        width = 1200;
        height = 440;
        prompt = ">";
        normal_window = true;
        allow_images = true;
        allow_markup = true;
        hide_scroll = false;
        location = "center";
        columns = 3;
        orientation = "vertical";
        halign = "fill";
        content_halign = "start";
        content_valign = "center";
        image_size = 50;
        dynamic_lines = "false";
        layer = "top";
      };

      style = ''

        /* ========== Root window ========== */
        #window {
        	margin: 10px;
        	border-radius: 4px;
        	background: linear-gradient(0deg,alpha(${colors.base00}, 0.3) 0%, alpha(${colors.base00}, 0.6) 100%);
        	font-family: JetBrains Mono, monospace;
        	font-size: 14px;
        }

        /* ========== Outer box  ========== */
        #outer-box {
        	padding: 0px;
        	background-color: transparent;
        }

        /* ========== Search bar ========== */
        #input {
        	margin: 10px;
        	padding: 10px;
        	border: 2px solid alpha(${colors.base05},0.8);
        	border-radius: 4px;
        	background-color: alpha(${colors.base00},1);
        	color: alpha(${colors.base05},1);
        	font-weight: bold;
        }


        /* ========== Scroll area ========== */
        #scroll {
        	background-color: transparent;
        	padding: 6px;
        }

        /* ========== Box holding entries ========== */
        #inner-box {
        	background-color: transparent;
        	padding: 5px;
        	margin: 0px;
        }

        /* ========== All entries ========== */
        #entry:nth-child(even),
        #entry:nth-child(odd){
        	padding: 8px;
        	margin: 2px;
        	border-radius: 3px;
        	background-color: alpha(${colors.base01},0.5);
        	color: alpha(${colors.base05},1);
        	transition: background 0.3s ease-out;
        }

        /* ========== Selected State ========== */
        #entry:selected {
        	background-color: alpha(${colors.base04},1);
        	color:  alpha(${colors.base00},1);
        	font-weight: bold;
        	transition: background 0.1s ease-out;
        }

        /* ========== Image inside entry (icons) ========== */
        #img {
        	margin-right: 10px;
        	border-radius: 6px;
        	background-color: transparent;
        	min-width: 0px;
        	min-height: 0px;
        	max-width: 120px;
        	max-height: 120px;
        }

        /* ========== Text inside entry ========== */
        #text {
        	color: inherit;
        	font-size: 14px;
        	margin-left: 4px;
        }

        /* ========== Expander box (multi-action apps) ========== */
        #expander-box {
        	background-color: alpha(${colors.base00},0.1);
        	border-radius: 4px;
        	padding: 4px;
        	margin-top: 6px;
        }

      '';
    };
  };
}
