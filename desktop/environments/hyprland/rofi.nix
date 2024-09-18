{
  config,
  lib,
  pkgs,
  ...
}: let
  usr = config.core.username;
  mkLiteral = value: {
    _type = "literal";
    inherit value;
  };
  cfg = config.desktop.type == "hyprland";
in {
  home-manager.users.${usr}.programs.rofi = {
    enable = cfg;
    cycle = true;
    package = pkgs.rofi-wayland;
    terminal = "${lib.getBin pkgs.kitty}";
    theme = {
      window = {
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        transparency = "screenshot";
        padding = mkLiteral "10px";
        border = mkLiteral "0px";
        border-radius = mkLiteral "6px";

        spacing = 0;
        children = mkLiteral "[mainbox]";
        orientation = mkLiteral "horizontal";
      };

      mainbox = {
        spacing = 0;
        children = mkLiteral "[ inputbar, message, listview ]";
      };

      message = {
        padding = 5;
        border = mkLiteral "0px 2px 2px 2px";
      };

      inputbar = {
        padding = mkLiteral "11px";

        border = mkLiteral "1px";
        border-radius = mkLiteral "6px 6px 0px 0px";
      };

      "entry, prompt, case-indicator" = {
        text-font = mkLiteral "inherit";
      };

      prompt = {
        margin = mkLiteral "0px 0.3em 0em 0em ";
      };

      listview = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "0px 0px 6px 6px";
        border = mkLiteral "0px 1px 1px 1px";
        dynamic = mkLiteral "false";
      };

      element = {
        padding = mkLiteral "3px";
        vertical-align = mkLiteral "0.5";
        border-radius = mkLiteral "4px";
      };

      button = {
        padding = mkLiteral "6px";
        horizontal-align = mkLiteral "0.5";

        border = mkLiteral "2px 0px 2px 2px";
        border-radius = mkLiteral "4px 0px 0px 4px";
      };

      "button selected normal" = {
        border = mkLiteral "2px 0px 2px 2px";
      };
    };
    extraConfig = {
      modi = "run,ssh,drun";
      display-ssh = "";
      display-run = "";
      display-drun = "";
      display-combi = "";
      show-icons = true;
      line-margin = 10;
      columns = 2;
    };
  };
}
