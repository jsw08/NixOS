{
  imports = [./hardware-configuration.nix];
  core.boot.animation = false;
  desktop.type = "none";
  server.minecraft = true;
}
