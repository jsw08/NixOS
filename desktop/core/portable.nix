{config, pkgs, lib, ...}: let
    cfg = config.desktop.portable;
in {
    options.desktop.portable = lib.mkEnableOption "settings related to portability. Usefull for laptops or other battery-powered devices.";
    config = {
        services.power-profiles-daemon.enable = lib.mkForce cfg;
    };
}