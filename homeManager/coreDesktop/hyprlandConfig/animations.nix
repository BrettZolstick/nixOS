{
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;

      bezier = [
        "quick, 0.15, 0, 0.1, 1"
      ];

      animation = [
        "global, 1, 2.5, quick"
      ];
    };
  };
}
