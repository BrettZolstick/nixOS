{lib, ...}: {
  imports =
    [
      # Imports hardware-configuration.nix from the default location
      # this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
      /etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

      # include a list of all .nix files recursively under this directory					  v---------------------v
    ]
    ++ lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../nixOSConfiguration/.);

  # Host specific options ################################################

  wsl.enable = true;
  wsl.defaultUser = "ethan";

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Optional Modules #####################################################

  home-manager.users.ethan = {
  
  };
}
