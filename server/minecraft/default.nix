{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.server.minecraft;
  inherit (pkgs) linkFarmFromDrvs fetchurl;

in {
  options.server.minecraft = lib.mkEnableOption "minecraft related services, to host an smp.";
  config = lib.mkIf cfg {
    environment.systemPackages = [pkgs.tmux pkgs.mcman];
    networking.firewall.allowedUDPPorts = [24454];
    networking.firewall.allowedTCPPorts = [25565];

    flux = {
      enable = true;
      servers.smp = {
	package = pkgs.mkMinecraftServer {
	  name = "smp";
	  src = ./modpack;
	  hash = "";
	};
      };
    };

  };
}
