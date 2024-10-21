{
  config,
  lib,
  pkgs,
  ...
}: let
  usr = config.core.username;
  cfg = config.desktop.type == "hyprland";
in {
  home-manager.users.${usr} = lib.mkIf cfg {
    home.packages = [pkgs.libnotify];
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
    };
  };
}
