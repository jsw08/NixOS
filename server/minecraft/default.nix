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
    packHash = "sha256-4yh3JdCvMMFUSMsuSvOeES2La4NkypAW0ypsdG9kEpY="; 
  };

  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  options.server.minecraft = lib.mkEnableOption "minecraft related services, to host an smp.";
  config = lib.mkIf cfg {
    environment.systemPackages = [pkgs.tmux pkgs.packwiz];
    networking.firewall.allowedUDPPorts = [24454];
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
	jvmOpts = "-Xms6144M -Xmx6144M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20";

	whitelist = {
	  jsuwu = "cbd3ea51-2acb-4b8c-b8b7-222f9914816f";
	};
        serverProperties = {
	  whitelist = true;
          view-distance = 12;
          difficulty = "hard";
          force-gamemode = true;
          motd = "Mental asylum (the game)";
        };

        symlinks = {
          "allowed_symlinks.txt" = pkgs.writeText "allowed_symlinks.txt" "/nix/store";
          "mods" = "${modpack}/mods";
          "config" = "${modpack}/config";
        };
      };
    };
  };
}
