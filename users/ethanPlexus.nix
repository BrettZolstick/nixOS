{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../themes/nightMountain.nix

    #../themes/niceMountain.nix
    #../themes/theLight.nix
    #../themes/buriedInTheSand.nix
  ];

  users.users.ethanPlexus = {
    isNormalUser = true;
    description = "Ethan's work account";
    extraGroups = ["networkmanager" "wheel" "inputs" "audio" "minecraftGTNH" "fileSharing"];
    openssh.authorizedKeys.keys = [];
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.ethanPlexus = {...}: {
      # import a list of all .nix files recursively under this directory		   		  	v-------------V
      imports = lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../homeManager);
      home.username = "ethanPlexus";
      home.homeDirectory = "/home/ethanPlexus";
      home.stateVersion = "25.05";
      home.pointerCursor = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 22;
      };
    };
  };
}
