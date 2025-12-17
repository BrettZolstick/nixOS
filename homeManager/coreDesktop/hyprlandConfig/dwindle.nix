{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    dwindle = {
      pseudotile = false;
      force_split = 0;
      preserve_split = false;
      smart_split = false;
      smart_resizing = true;
      permanent_direction_override = false;
      special_scale_factor = 1;
      split_width_multiplier = 1;
      use_active_for_splits = true;
      default_split_ratio = 1;
      split_bias = 0;
    };
  };
}
