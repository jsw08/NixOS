{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  username = "jsw";
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
  };
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users.${username} = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";
      
      programs.home-manager.enable = true;
      home.stateVersion = system.stateVersion;
    };
  };

}
