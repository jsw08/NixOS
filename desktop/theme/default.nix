{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.desktop.type != "none";
in
{
  stylix = {
    enable = true;
    polarity = "dark";
    image = ./wallpaper.jpg;
  };
}
