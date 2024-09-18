{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.type == "gnome";
in
{
  config = lib.mkIf cfg {
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
    environment.gnome.excludePackages = [ pkgs.epiphany ];
  };
}
