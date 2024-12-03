{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.apps.games.enabled && config.desktop.type != "none";
in {
  config = lib.mkIf cfg {
    hardware.steam-hardware.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true; # x11 input to wayland.
    };
  };
}
