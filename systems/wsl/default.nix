{
  config,
  inputs,
  ...
}: {
  imports = [inputs.nixos-wsl.nixosModules.default ./hardware-configuration.nix];

  desktop.type = "hyprland";
  core.boot.enable = false;
}
