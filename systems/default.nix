{
  self,
  inputs,
  lib,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem genAttrs;
    inherit (inputs) home-manager stylix;

    specialArgs = {inherit inputs self;};
    modules = [
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix

      ../apps
      ../core
      ../desktop
    ];
    systems = [
      "desktop"
      "wsl"
    ];
  in (genAttrs systems (hostName:
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
    }));
}
