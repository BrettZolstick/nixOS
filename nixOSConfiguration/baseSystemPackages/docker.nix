{
  config,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    docker.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.docker.enable {
    # Actual content of the module goes here:

    virtualisation.docker.enable = true;
   
  };
}
