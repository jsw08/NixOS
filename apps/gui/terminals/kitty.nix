{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.desktop.type != "none"; #config.apps.APP;
  usr = config.core.username;
in {
  # options.apps.APP = lib.mkOption {
  #   type = lib.types.bool;
  #   default = true;
  #   example = false;
  #   description = "Wether to enable the APP.";
  # };

  home-manager.users.${usr}.programs.kitty = {
    enable = cfg;
  };
}
