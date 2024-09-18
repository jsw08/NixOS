{
  self,
  inputs,
  lib,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem genAttrs;

  specialArgs = {inherit inputs self;};
  modules = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    ../apps
    ../core
    ../desktop
  ];
in {
  flake = let
    systems = [
      "desktop"
      "wsl"
    ];
  in {
    # Systems
    nixosConfigurations = genAttrs systems (hostName:
      nixosSystem {
        inherit specialArgs;
        modules =
          modules
          ++ [
            {
              imports = [./${hostName}];
              networking = {inherit hostName;};
            }
          ];
      });
  };

  perSystem = {
    # Allows running 'nix run github:jsw08/NixOS' and it'll spin up a vm.
    config,
    pkgs,
    ...
  }: let
    nixos-vm = nixosSystem {
      inherit specialArgs;
      modules =
        modules
        ++ [
          {
            networking.hostName = "vm";
            core.username = "user";
            nixpkgs.hostPlatform = pkgs.system;

            desktop.type = "hyprland";
          }
        ];
    };
  in {
    apps.default = {
      type = "app";
      program = "${nixos-vm.config.system.build.vm}/bin/run-vm-vm";
    };
  };
}
