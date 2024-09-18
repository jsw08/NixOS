{
  config,
  lib,
  ...
}: let
  cfg = config.desktop.type == "hyprland";
  usr = config.core.username;
in {
  home-manager.users.${usr}.programs.waybar = {
    enable = cfg;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
  };
}
