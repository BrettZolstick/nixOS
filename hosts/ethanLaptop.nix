{
  lib,
  ...
}: {
  imports =
    [
      # Imports hardware-configuration.nix from the default location
      # this allows for the configuration to be built straight from github on any NixOS with flakes enabled.
      /etc/nixos/hardware-configuration.nix # needs the --impure switch when running nixos-rebuild

      # include a list of all .nix files recursively under this directory					  v---------------------v
    ]
    ++ lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../nixOSConfiguration/.);

  # Host specific options ################################################

  networking.hostName = "ethanLaptop";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Optional Modules #####################################################

  nvidiaGraphics.enable = true;
  rcloneShares.enable = true;
  sshInto.enable = true;

  home-manager.users.ethan = {
    aniCli.enable = true;
    firefox.enable = true;
    furnace.enable = true;
    gamescope.enable = true;
    mangohud.enable = true;
    musescore.enable = true;
    osuLazer.enable = true;
    prismLauncher.enable = true;
    renoise.enable = true;
    todoist.enable = true;
    vesktop.enable = true;
    woeusb.enable = true;
    qdirstat.enable = true;
    office.enable = true;
  };
}
