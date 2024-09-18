{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop.type != "none";
in {
  stylix = {
    enable = true;
    polarity = "dark";
    image = ./wallpaper.jpg;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 21;
    };
    fonts.monospace = {
      name = "DejaVuSansMNerdFontMono-Regular";
      package = pkgs.nerdfonts.override {fonts = ["DejaVuSansMono"];};
    };
  };
}
