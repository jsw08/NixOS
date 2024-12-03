{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types getExe';
  opt = lib.optionalString;
  exe = lib.getExe;
  hm = config.home-manager.users.${usr};

  usr = config.core.username;
  cfg = config.desktop.type == "hyprland";

  terminal = hm.programs.kitty.package;
  rofi = hm.programs.rofi.package;
  firefox = hm.programs.firefox.package;
  hyprctl = "${hm.wayland.windowManager.hyprland.package}/bin/hyprctl";
  inherit (config.lib.stylix) colors;
in {
  config = mkIf cfg {
    programs.hyprland.enable = true;
    home-manager.users.${usr} = {
      home.packages = [
        pkgs.wl-clipboard
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          # Autolaunch
          #exec = ["${lib.getExe pkgs.foot}"];

          # Settings, thx fufexan!
          general = {
            gaps_in = 5;
            gaps_out = 5;
            border_size = 2;

            allow_tearing = true;
            resize_on_border = true;
          };
          group = {
            groupbar = {
              font_size = 10;
              gradients = false;
            };
          };

          input = {
            kb_layout = "us";

            follow_mouse = 1;
            touchpad.scroll_factor = 0.1;
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_forever = true;
          };
          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };
          misc = {
            disable_autoreload = true;
            force_default_wallpaper = 0;
            animate_mouse_windowdragging = false;
            vrr = 2;
          };
          render.direct_scanout = true;
          xwayland.force_zero_scaling = true;

          decoration = {
            rounding = 10;
            blur = {
              enabled = true;
              size = 10;
              passes = 2;
              new_optimizations = true;
              ignore_opacity = true;
              xray = true;
            };
            active_opacity = 0.85;
            inactive_opacity = 0.6;
            fullscreen_opacity = 0.95;

            # drop_shadow = true;
            # shadow_range = 30;
            # shadow_render_power = 3;
          };
          animations = {
            enabled = true;
            animation = [
              "border, 1, 2, default"
              "fade, 1, 4, default"
              "windows, 1, 3, default, popin 80%"
              "workspaces, 1, 2, default, slide"
            ];
          };

          # Keybinds
          "$mod" = "ALT";
          bind =
            [
              # Hyprbinds
              "$mod, Q, killactive"
              "$mod, F, fullscreen"
              "$mod, P, togglesplit # dwindle"
              "$mod, SPACE, togglefloating"
              "$mod SHIFT, E, exit"

              # Programbinds
              ", Print, exec, ${exe pkgs.grimblast} copy area"
              "$mod, D, exec, ${exe rofi} -show drun"
              "$mod, RETURN, exec, ${exe terminal}"
              "$mod SHIFT, RETURN, exec, ${exe firefox}"
              "$mod, ESCAPE, exec, ${exe hm.programs.hyprlock.package}"

              "$mod, a, exec, ${exe terminal} ${exe pkgs.pulsemixer}"
              "$mod, n, exec, ${exe terminal} ${pkgs.networkmanager}/bin/nmtui"
              (opt config.core.bluetooth "$mod, b, exec, ${exe terminal} ${exe pkgs.bluetuith}")

              # Bar alternative
              "$mod, z, exec, ${hyprctl} notify -1 4000 \"rgb(${colors.base06})\" \" $(date +'%d/%m/%Y - %H:%M:%S')\""
              "$mod, z, exec, ${hyprctl} notify -1 4000 \"rgb(${colors.base08})\" \"    $(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2)\""
              "$mod, z, exec, ${hyprctl} notify -1 4000 \"rgb(${colors.base08})\" \"󰁹 batt\""

              # Movement binds
              "$mod, G, togglegroup"
              "$mod SHIFT, G, changegroupactive"
              "$mod, H, movefocus, l"
              "$mod, L, movefocus, r"
              "$mod, K, movefocus, u"
              "$mod, J, movefocus, d"

              "$mod SHIFT, H, movewindow, l"
              "$mod SHIFT, L, movewindow, r"
              "$mod SHIFT, K, movewindow, u"
              "$mod SHIFT, J, movewindow, d"
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
          binde = [
            "$mod CTRL, H, resizeactive, -50 0"
            "$mod CTRL, L, resizeactive, 50 0"
            "$mod CTRL, K, resizeactive, 0 -50"
            "$mod CTRL, J, resizeactive, 0 50"
          ];
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}
