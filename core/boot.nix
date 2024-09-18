{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.core.boot.enable;
in {
  options.core.boot.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs the systemd-boot bootloader. Possible to disable for wsl.";
  };

  config.boot = lib.mkIf cfg {
    loader = {
      systemd-boot.enable = cfg; # NixOS-wsl support.
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
  };
}
