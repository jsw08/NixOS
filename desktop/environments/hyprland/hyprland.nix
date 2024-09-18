{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption types getExe getExe';
  opt = lib.optionalString;
  hm = config.home-manager.users.${usr};

  usr = config.core.username;
  cfg = config.desktop.type == "hyprland";

  rofi = hm.programs.rofi.package;
  firefox = hm.programs.firefox.package;
in {
  options.desktop.hyprland.monitor = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      monitor configuration for setup
      (monitor,resolution@hertz,position,scale
      example: HDMI-A-1, 2560x1080@60, 0x0, 1)
    '';
  };
  config = {
    programs.hyprland.enable = cfg;
    home-manager.users.${usr} = {
      wayland.windowManager.hyprland = {
        enable = cfg;
        settings = {
          inherit (config.desktop.hyprland) monitor;

          exec = ["${lib.getExe pkgs.foot}"];

          decoration = {
            # shadow stuff
            drop_shadow = true;
            shadow_offset = "5 5";
          };
          input = {
            kb_layout = "us";
          };

          "$mod" = "ALT";
          bind =
            [
              "$mod, Q, killactive,"
              "$mod SHIFT, E, exit"
              "$mod, D, exec, ${getExe rofi} -show drun"

              (opt config.apps.firefox "$mod, F, exec, ${getExe firefox}")
              "$mod, RETURN, exec, ${getExe pkgs.kitty}"
            ]
            ++ (
              # workspaces
              # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
              builtins.concatLists (
                builtins.genList (
                  x: let
                    ws = let
                      c = (x + 1) / 10;
                    in
                      builtins.toString (x + 1 - (c * 10));
                  in [
                    "$mod, ${ws}, workspace, ${toString (x + 1)}"
                    "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                  ]
                )
                10
              )
            );
        };
      };
    };
  };
}
