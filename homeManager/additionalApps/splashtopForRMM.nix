{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Build a launcher installed in the Nix store.
  splashtopLauncher = pkgs.writeShellScriptBin "splashtop-rmm" ''
    # Exit on command failures and undefined variables.
    set -euo pipefail

    # Reference the existing Steam installation.
    steamDir="$HOME/.steam/steam/steamapps"

    # Reuse the prefix created by your original installer.
    compatDir="$steamDir/compatdata/3053166391"

    # Use the Proton version you selected in Steam.
    proton="$steamDir/common/Proton - Experimental/proton"

    # Locate Splashtop's RMM connection handler.
    client="$compatDir/pfx/drive_c/Program Files (x86)/Splashtop/Splashtop Remote/Client for RMM/clientoobe.exe"

    # Reject missing arguments or unexpected URL schemes.
    if [[ $# -ne 1 || "$1" != st-rmm:* ]]; then
      echo "Expected one st-rmm URL." >&2
      exit 1
    fi

    # Check that the required files exist.
    if [[ ! -f "$proton" || ! -f "$client" ]]; then
      echo "Proton or Splashtop executable not found." >&2
      exit 1
    fi

    # Specify the existing Windows compatibility environment.
    export STEAM_COMPAT_DATA_PATH="$compatDir"

    # Tell Proton where Steam is installed.
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"

    # Launch the connection handler with the complete URL.
    exec "$proton" run "$client" -a "$1"
  '';
in
{
  # This is wrapped in an option so that it can be easily toggled elsewhere.
  options = {
    splashtopForRMM.enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf config.splashtopForRMM.enable {
    # Actual content of the module goes here:
    # Install the generated launcher into your user environment.
    home.packages = [
      splashtopLauncher
    ];

    # Register the application with your desktop environment.
    xdg.desktopEntries.splashtop-rmm = {
      name = "Splashtop for RMM";

      # Forward the connection URL using the %u placeholder.
      exec = "${splashtopLauncher}/bin/splashtop-rmm %u";

      # Associate this entry with the st-rmm URL scheme.
      mimeType = [ "x-scheme-handler/st-rmm" ];

      # Keep it out of the normal application menu. (opt.)
      noDisplay = true;

      # Do not open an extra terminal.
      terminal = false;
    };

    # Declaratively manage protocol associations.
    xdg.mimeApps = {
      enable = true;

      # Select Splashtop when an st-rmm link is opened.
      defaultApplications = {
        "x-scheme-handler/st-rmm" = "splashtop-rmm.desktop";
      };
    };

    
  };
}
