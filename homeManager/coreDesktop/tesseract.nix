{
  config,
  pkgs,
  lib,
  ...
}: {
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    tesseract.enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.tesseract.enable {
    # Actual content of the module goes here:
    home.packages = with pkgs; [tesseract];
  };
}
