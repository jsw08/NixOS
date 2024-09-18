{
  config,
  lib,
  ...
}: let
  cfg = config.desktop.type;
in {
  imports = [
    ./core
    ./environments
    ./theme
  ];
}
