{
  imports = [ ./hardware-configuration.nix ];

  core = {
    gpu = "amd";
    bluetooth = true;
  };

  desktop.type = "kde";
}
