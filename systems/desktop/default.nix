{config, pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  core = {
    boot.animation = true;
    gpu = "amd";
    bluetooth = true;
  };

  desktop = {
    type = "gnome";
    # hyprland.monitor = [
    #   "DP-1, 2560x1440@164, 0x0, 1, bitdepth, 10"
    # ];
  };
  server.minecraft = true;
}
