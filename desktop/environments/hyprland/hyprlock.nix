{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.lib.stylix.colors) base00 base0D base05 base06 base0F;
  usr = config.core.username;
  cfg = config.desktop.type == "hyprland";
in {
  security.pam.services.hyprlock = mkIf cfg {};
  home-manager.users.${usr}.programs.hyprlock = mkIf cfg {
    enable = true;
    settings = {
      background = {
        path = "screenshot";
        blur_passes = 2;
        blur_size = 5;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 1.5;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = false;
        dots_rounding = -1;
        dots_fade_time = 200;
        dots_text_format = "";
        outer_color = "rgb(${base0D})";
        inner_color = "rgb(${base00})";
        font_color = "rgb(${base05})";
        font_family = "Noto Sans";
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        rounding = 10;
        check_color = "rgb(${base06})";
        fail_color = "rgb(${base0F})";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_timeout = 2000;
        fail_transition = 300;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = false;

        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };
}
