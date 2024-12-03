{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  usr = config.core.username;
in {
  config.home-manager.users.${usr} = {
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        gnumake
        gcc
        ripgrep
        unzip
        git
        xclip
      ];
    };

    xdg.configFile.nvim = {
      source = inputs.nvim;
      recursive = true;
    };
  };
}
