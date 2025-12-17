{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    git.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.git.enable {
    # Actual content of the module goes here:

    programs.git = {
      enable = true;
      settings.user.name = "Ethan";
      settings.user.email = "crazyeman83@gmail.com";
    };
  };
}
