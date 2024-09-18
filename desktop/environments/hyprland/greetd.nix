{config, lib, pkgs, ...}: let
  usr = config.core.username;
  cmd = "Hyprland";
  greeting = "";

  greeter = "${lib.getExe pkgs.greetd.tuigreet} --user-menu -r -t -g '${greeting} -c ${cmd}";
in {
  services.greetd = {
    enable = true;
    settings = {
       default_session.command = greeter;
       initial_session = {
         command = cmd;
	 user = config.core.username;
       };
    };
  };
};
