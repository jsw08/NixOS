{
  config,
  lib,
  ...
}: let
  cfg = config.desktop.type == "hyprland";
  usr = config.core.username;
in {
  home-manager.users.${usr}.programs.waybar = {
    enable = cfg;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings.main = {
      margin-top = 5;
      margin-left = 1;
      margin-right = 1;
      height = 35;
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [
        "hyprland/window"
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "battery"
        "clock"
      ];
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        sort-by-number = true;
      };
      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      cpu = {
        format = "  {usage}%";
        tooltip = false;
      };
      memory = {
        format = "{}%  ";
      };
      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}  {capacity}%";
        format-full = "{icon}  {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = "  {capacity}%";
        format-alt = "{time} {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "{ipaddr}/{cidr} ";
        tooltip-format = "{ifname} via {gwaddr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = " ⚠ ";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };
      pulseaudio = {
        format = "{icon}  {volume}%";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Roboto Mono SemiBold, Iosevka Nerd Font;
        font-size: 18px;
        font-style: normal;
        min-height: 0;
      }

      window#waybar {
        background: @base00;
        opacity: 0.8; /* Set opacity for transparency */
        color: @base0C;
      }

      /* Workspaces */
      #workspaces {
        background: @base01;
        margin: 5px;
        padding: 8px 5px;
        border-radius: 0 0 16px 0; /* Rounded top corners */
        font-weight: normal;
      }

      #workspaces button {
        padding: 0 5px;
        margin: 0 3px;
        border-radius: 16px;
        color: @base0D;
        background-color: @base02;
        transition: all 0.3s ease-in-out;
        min-width: 20px;
      }

      #workspaces button.active,
      #workspaces button:hover {
        color: @base02;
        background-color: @base0C;
        background-size: 400% 400%;
      }

      /* Status Indicators */
      #clock,
      #pulseaudio,
      #network,
      #battery,
      #cpu,
      #memory,
      #disk,
      #language,
      #windows {
        background-color: @base01;
        color: @base0A;
        border-radius: 16px;
        margin: 5px;
        padding: 0 10px;
        font-weight: bold;
      }

      #clock {
        color: @base0C;
        border-radius: 0 0 0 24px; /* Rounded bottom left corner */
        padding: 0 15px;
        margin-left: 10px;
      }

      #network {
        color: @base0C;
        border-radius: 8px;
      }

      #pulseaudio {
        color: @base0E;
        background: @base01; /* Ensure background is consistent */
      }

      /* Battery */
      #battery {
        background-color: @base03; /* Assign a distinct background color for battery */
        color: @base0B; /* Color for battery text */
        border-radius: 16px;
        margin: 5px;
        padding: 0 10px;
        font-weight: bold;
      }

      /* General Window Styles */
      #window,
      #cpu,
      #memory,
      #disk,
      #language {
        background: @base01;
        padding: 0 10px;
        border-radius: 16px;
        margin: 5px;
        font-weight: normal;
      }

    '';
  };
}
