{config, ...}: let
  usr = config.core.username;
  cfg = config.desktop.type == "hyprland";
in {
  home-manager.users.${usr}.services.mako = {
    enable = cfg;
    defaultTimeout = 5000;
  };
}
