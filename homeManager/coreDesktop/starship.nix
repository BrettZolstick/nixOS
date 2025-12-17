{
  config,
  lib,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;

  logoBg = colors.base05;
  logoFg = colors.base00;
  directoryBg = colors.base04;
  directoryFg = colors.base00;
  gitBg = colors.base03;
  gitFg = colors.base00;
  gitStatusFg = colors.base06;
  devLangBg = colors.base02;
  devLangFg = colors.base00;
  timeBg = colors.base01;
  timeFg = colors.base05;
  cmdDuration = colors.base02;
in {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    starship.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.starship.enable {
    # Actual content of the module goes here:

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        format = "[](${logoBg})[  ](bg:${logoBg} fg:${logoFg})$hostname[](fg:${logoBg} bg:${directoryBg})$directory[](fg:${directoryBg} bg:${gitBg})$git_branch$git_status[](fg:${gitBg} bg:${devLangBg})$nodejs$rust$golang$php[](fg:${devLangBg} bg:${timeBg})$time[](fg:${timeBg})$cmd_duration\n$character";

        hostname = {
          ssh_only = true;
          ssh_symbol = "󰢹 ";
          format = "[$hostname $ssh_symbol]($style)";
          style = "bold bg:${logoBg} fg:${logoFg}";
        };

        directory = {
          style = "fg:${directoryFg} bg:${directoryBg}";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          truncate_to_repo = false;
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:${gitBg}";
          format = "[[ $symbol $branch ](fg:${gitFg} bg:${gitBg})]($style)";
        };

        git_status = {
          style = "bg:${gitBg}";
          diverged = "[[  \${ahead_count} \${behind_count}](bg:${gitBg} fg:${gitStatusFg})]($style)";
          ahead = "[[ \${count}](bg:${gitBg} fg:${gitStatusFg})]($style)";
          behind = "[[ \${count}](bg:${gitBg} fg:${gitStatusFg})]($style)";
          modified = "[[ !\${count}](bg:${gitBg} fg:${gitStatusFg})]($style)";
          staged = "[[ +\${count}](bg:${gitBg} fg:${gitStatusFg})]($style)";
          format = "[[($all_status$ahead_behind )](bg:${gitBg} fg:${gitFg})]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:${devLangBg} fg:${devLangFg}";
          format = "[[ $symbol ($version) ](fg:${devLangFg} bg:${devLangBg})]($style)";
        };

        rust = {
          symbol = " ";
          style = "bg:${devLangBg} fg:${devLangFg}";
          format = "[[ $symbol ($version) ](fg:${devLangFg} bg:${devLangBg})]($style)";
        };

        golang = {
          symbol = "";
          style = "bg:${devLangBg} fg:${devLangFg}";
          format = "[[ $symbol ($version) ](fg:${devLangFg} bg:${devLangBg})]($style)";
        };

        php = {
          symbol = " ";
          style = "bg:${devLangBg} fg:${devLangFg}";
          format = "[[ $symbol ($version) ](fg:${devLangFg} bg:${devLangBg})]($style)";
        };

        nix_shell = {
          symbol = " ";
          style = "bg:${devLangBg} fg:${devLangFg}";
          format = "[[ $symbol ($version) ](fg:${devLangFg} bg:${devLangBg})]($style)";
        };

        time = {
          disabled = false;
          time_format = "%r";
          style = "bg:${timeBg}";
          format = "[[  $time ](fg:${timeFg} bg:${timeBg})]($style)";
        };

        cmd_duration = {
          min_time = 2000;
          min_time_to_notify = 45000;
          show_milliseconds = false;
          style = "light";
          format = "[[  $duration](fg:${cmdDuration})]($style)";
        };
      };
    };
  };
}
