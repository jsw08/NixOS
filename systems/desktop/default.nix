{
  imports = [./hardware-configuration.nix];

  core = {
    boot.animation = true;
    gpu = "amd";
    bluetooth = true;
  };

  desktop.type = "gnome";
}
