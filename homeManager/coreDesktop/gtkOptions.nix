{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    gtkOptions.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.gtkOptions.enable {
    # Actual content of the module goes here:

    # GTK
    gtk.gtk4.theme = lib.mkForce config.gtk.theme;


  };
}
