{
  imports = [./hardware-configuration.nix];

  core = {
    boot.animation = true;
    gpu = "amd";
    bluetooth = true;
  };

  desktop = {
    type = "hyprland";
    hyprland.monitor = [
      "DP-1, 2560x1440@164, 0x0, 1, bitdepth, 10, vrr, 1"
    ];
  };

  server.minecraft = true;
}
