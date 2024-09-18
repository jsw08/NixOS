{config, lib, ...}: let
  usr = config.core.username;
in {
  wsl = {
    enable = true;
    defaultUser = usr;
  }; 
  nixpkgs.hostPlatform = "x86_64-linux";
}
