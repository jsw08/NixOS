{
  description = "Nix is here, nix is everywhere, nix is everything.";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        ./systems
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.alejandra
            pkgs.git
          ];
          name = "dots";
          DIRENV_LOG_FORMAT = "";
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    # Nixpkgs and other core shit
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small"; # build error unrelated to config.
    flake-parts.url = "github:hercules-ci/flake-parts";
    wivrn-20.url = "github:PassiveLemon/nixpkgs/wivrn-update";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Ricing
    stylix.url = "github:danth/stylix";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Server related inputs
    flux.url = "github:IogaMaster/flux";

    # My non-nix neovim config
    nvim = {
      url = "github:jsw08/nvim";
      flake = false;
    };
  };
}
