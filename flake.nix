{
  description = "Nix is here, nix is everywhere, nix is everything.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small"; # build error unrelated to config.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Ricing
    stylix.url = "github:danth/stylix";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      modules_paths = [
        home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        ./systems
        ./apps
        ./desktop
      ];

    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            hostname = "desktop";
          };
          modules = modules_paths;
        };
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            hostname = "wsl";
          };
          modules = modules_paths ++ [ inputs.nixos-wsl.nixosModules.default ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
