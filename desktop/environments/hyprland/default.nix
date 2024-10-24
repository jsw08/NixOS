{
  imports = [
    ./greetd.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./mako.nix
    ./rofi.nix
  ];
  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };
}
