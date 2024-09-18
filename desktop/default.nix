{ config, lib, ... }:
let
  cfg = config.desktop.type;
in
{
  options.desktop.type = lib.mkOption {
    type = lib.types.enum [
      "gnome"
      "none"
    ];
    default = "none";
    example = "gnome";
    description = "What desktop should be enabled.";
  };
  imports = [
    ./gnome
    ./hyprland
    ./kde
    ./theme
  ];
}
