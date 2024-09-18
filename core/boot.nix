{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.core.boot;
in {
  options.core.boot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Installs the systemd-boot bootloader. Possible to disable for wsl.";
    };
    animation = lib.mkEnableOption "the boot process needs to look nice.";
  };

  config.boot = mkIf cfg.enable {
    # NixOS-wsl support.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;

    # Boot animation
    plymouth.enable = cfg.animation;

    # Silent boot and related.
    consoleLogLevel = mkIf cfg.animation 0;
    initrd.verbose = cfg.animation;
    kernelParams = mkIf cfg.animation [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Hide the OS choice for bootloaders. It's still possible to open the bootloader list by pressing any key  It will just not appear on screen unless a key is pressed
    loader.timeout = mkIf cfg.animation 0;
  };
}
