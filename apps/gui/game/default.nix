{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.apps.games;
in {
  options.apps.games.enabled = lib.mkEnableOption "game launchers and other gaming related programs. Desktop has to be enabled for this to work.";

  imports = [
    ./steam.nix
    # ./wivrn.nix
  ];
}
