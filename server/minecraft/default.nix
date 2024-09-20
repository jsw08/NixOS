{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.server.minecraft;
  inherit (pkgs) linkFarmFromDrvs fetchurl;

  modpack = pkgs.fetchPackwizModpack {
    url = "https://github.com/jsw08/server-modpack/raw/master/pack.toml";
    packHash = "sha256-LhfCYPSG68zDhP9AwncF17uq/m5G+0JZQwpfHP+qTwk=";
  };

  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  options.server.minecraft = lib.mkEnableOption "minecraft related services, to host an smp.";
  config = lib.mkIf cfg {
    environment.systemPackages = [pkgs.tmux pkgs.packwiz];
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      servers.smp = {
        enable = true;
        autoStart = true;
        package = pkgs.minecraftServers.${serverVersion}.override {
          jre_headless = pkgs.graalvm-ce;
          loaderVersion = fabricVersion;
        };

        serverProperties = {
          view-distance = 12;
          difficulty = "hard";
          force-gamemode = true;
          motd = "Mental asylum (the game)";
        };

        symlinks = {
          "allowed_symlinks.txt" = pkgs.writeText "allowed_symlinks.txt" "/nix/store";
          "mods" = "${modpack}/mods";
        };
      };
    };
  };
}
