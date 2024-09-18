{
  config,
  lib,
  pkgs,
  ...
}: let
  usr = config.core.username;
  cmd = "Hyprland";
  greeting = "";

  greeter = "${lib.getExe pkgs.greetd.tuigreet} --user-menu -r -t --power-reboot 'systemctl reboot --firmware' -g '${greeting}' -c ${cmd}";
  cfg = config.desktop.type == "hyprland";
in {
  services.greetd = {
    enable = cfg;
    settings = {
      default_session.command = greeter;
      initial_session = {
        command = cmd;
        user = config.core.username;
      };
    };
  };
}
