{
    config,
    lib,
    pkgs,
    inputs,
    outputs,
    ...
}: let
    username = config.core.username;
in {
    options.core.username = lib.mkOption {
        type = lib.types.str;
        default = "jsw";
        example = "user";
        description = "Sets the main user's username.";
    };
    config = {
        users.users.${username} = {
            isNormalUser = true;
            description = "Main user";
            extraGroups = [
                "networkmanager"
                "wheel"
                "plugdev"
            ];
        };
        home-manager = {
            extraSpecialArgs = {
                inherit inputs outputs;
            };
            users.${username} = {
                home = {
                inherit username;
                homeDirectory = "/home/${username}";
                };

                # Nicely reload system units when changing configs
                systemd.user.startServices = "sd-switch";
                
                programs.home-manager.enable = true;
                home.stateVersion = system.stateVersion;
            };
        };
    };
}