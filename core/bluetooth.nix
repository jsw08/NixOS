{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.core.bluetooth;
in
{
  options.core.bluetooth = lib.mkEnableOption "enable bluetooth support.";
  config = lib.mkIf cfg {
    hardware.bluetooth = {
      enable = true;
      input.General.ClassicBondedOnly = true; # Support with legacy devices, such as the PS3 controller.
    };
    environment.systemPackages = [ pkgs.bluetuith ];
  };
}
