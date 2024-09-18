{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.apps.APP;
  usr = config.core.username;
in {
  options.apps.APP = lib.mkOption {
    type = lib.types.boolean;
    default = true;
    example = false;
    description = "Wether to enable the APP.";
  };

  config.home-manager.users.${usr} =
    lib.mkIf cfg {
    };
}
