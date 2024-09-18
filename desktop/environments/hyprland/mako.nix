{config, ...}: let
  usr = config.core.username;
in {
    home-manager.users.${usr}.services.mako = {
        enable = true;
        defaultTimeout = 5000;
    };
}
