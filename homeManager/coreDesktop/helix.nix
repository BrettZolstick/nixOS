{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    helix.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.helix.enable {
    # Actual content of the module goes here:

    home.packages = with pkgs; [nixd alejandra];

    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = lib.mkForce "mytheme";

        editor = {
          cursor-shape = {
            normal = "bar";
            insert = "bar";
            select = "bar";
          };

          indent-guides = {
            render = true;
          };

          auto-completion = true;
          completion-trigger-len = 1;
          completion-timeout = 5;
        };
      };

      themes.mytheme = {
        inherits = "stylix";

        #overrides to the generated stylix theme go here:

        "ui.virtual.indent-guide" = {fg = "#202020";};
      };

      languages = {
        "language-server" = {
          nixd = {
            command = "nixd";
            config = {
              nixpkgs.expr = "import (builtins.getFlake \"path:${config.home.homeDirectory}/nixOS\").inputs.nixpkgs { }";
              options.nixos.expr = "(builtins.getFlake \"path:${config.home.homeDirectory}/nixOS\").nixosConfigurations.${osConfig.networking.hostName}.options";
            };
          };
        };

        language = [
          {
            name = "nix";
            "language-servers" = ["nixd"];
            formatter = {command = "alejandra";};
          }
        ];
      };
    };
  };
}
