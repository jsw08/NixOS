{
  config,
  pkgs,
  lib,
  ...
}: let
  dataDir = "/var/lib/minecraft";
  mcUser = "minecraft";
  jvmArgs = "";

  cfg = config.server.minecraft;
  fabric = pkgs.fetchurl {
    url = "https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.5/1.0.1/server/jar";
    sha256 = "0mkmncdfxgkkpww2byvk3bbd968x44gxfild44qv04nv1lpcjfi4";
  };
  screen = lib.getExe pkgs.screen;
  usr = config.core.username;
in {
  options.server.minecraft = lib.mkEnableOption "the minecraft server.";

  config = lib.mkIf cfg {
    # Create the user if it doesn't exist
    users.users.minecraft = {
      createHome = true;
      isSystemUser = true;
      home = dataDir;
      group = "minecraft";
    };
    users.groups.minecraft = {};
    users.users.${usr}.extraGroups = ["minecraft"];

    # Define a systemd service to run the Minecraft server
    systemd.services.minecraft-server = {
      description = "Minecraft Server";
      after = ["network.target"];
      wants = ["network.target"];
      serviceConfig = {
        User = "minecraft";
        WorkingDirectory = dataDir;
        Restart = "always";
        RestartSec = 5;
        Nice = "-5";

        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "full";

        PrivateDevices = true;
        PrivateUsers = true;

        ExecStartPre = lib.getExe (pkgs.writeShellScriptBin "minecraft-server-pre-start" ''
	  chmod -R ug+rwx ~ 
	  
          if [ -e "./mods" ]; then
            rm -r ./mods
          fi
          chmod -R u+rw ./config

          ln -s ${./mods} ./mods
	  false | cp -ir ${./config}/. ./config
	  cp -r ${./root}/. .

	  chmod -R ug+rwx ~ 
        '');
        ExecStart = "${screen} -DmS minecraft ${pkgs.graalvm-ce}/bin/java ${jvmArgs} -jar ${fabric} nogui";
        ExecStop = lib.getExe (pkgs.writeShellScriptBin "minecraft-server-stop" ''
	  function server_running {
	      ${screen} -ls minecraft
	  }

          if ! server_running; then
              exit 0
          fi

          ${screen} -S minecraft -X stuff "stop^M" 

          while server_running; do
              sleep 0.25
          done
        '');
      };
      wantedBy = ["multi-user.target"];
    };

    # MC and simple voice chat
    networking.firewall.allowedUDPPorts = [24454];
    networking.firewall.allowedTCPPorts = [25565];
    environment.systemPackages = [pkgs.screen];
  };
}
