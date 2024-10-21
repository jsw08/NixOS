{
  config,
  pkgs,
  ...
}: let
  usr = config.core.username;
in {
  imports = [./hardware-configuration.nix ./envision.nix];

  core = {
    boot.animation = true;
    gpu = "amd";
    bluetooth = true;
  };

  desktop.type = "hyprland";
  home-manager.users.${usr}.wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1, 2560x1440@164, 0x0, 1, bitdepth, 10"
      "HDMI-A-1, 1920x1080@60, 2560x180, 1, bitdepth, 10"
    ];
    workspace = [
      "r[1-5], monitor:DP-1"
      "r[6-10], monitor:HDMI-A-1"
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = [
    "v4l2loopback"
  ];
}
