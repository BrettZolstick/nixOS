{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.helix.enable {
    programs.helix.settings.theme = lib.mkForce "mytheme";
    programs.helix.themes.mytheme = {
      inherits = "stylix";
      # overrides to the generated stylix theme go here.
      "ui.virtual.indent-guide" = {fg = "#202020";};
    };
  };
}
