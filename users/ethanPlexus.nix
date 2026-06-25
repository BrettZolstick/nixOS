{
  pkgs,
  lib,
  ...
}:
  let
    currentUserName = "ethanPlexus";
  in
{
  imports = [
    ../themes/nightMountain.nix

    #../themes/niceMountain.nix
    #../themes/theLight.nix
    #../themes/buriedInTheSand.nix
  ];

  users.users.${currentUserName} = {
    isNormalUser = true;
    description = "Plexus account";
    extraGroups = ["networkmanager" "wheel" "inputs" "audio" "minecraftGTNH" "fileSharingi" "docker"];
    openssh.authorizedKeys.keys = [];
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${currentUserName} = {...}: {
      # import a list of all .nix files recursively under this directory		   		  	v-------------V
      imports = lib.filter (n: lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../homeManager);
      home.username = currentUserName;
      home.homeDirectory = "/home/${currentUserName}";
      home.stateVersion = "25.05";
      home.pointerCursor = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
        size = 22;
      };
    };
  };
}
