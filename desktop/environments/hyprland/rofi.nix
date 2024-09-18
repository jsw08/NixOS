{config, lib, pkgs, ...}: let
  usr = config.core.username;
in {
    home-manager.users.${usr}.programs.rofi = {
        enable = true;
	cycle = true;
	package = pkgs.rofi-wayland;
	terminal = "${lib.getBin pkgs.kitty}"
    };
}
