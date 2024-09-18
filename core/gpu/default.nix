{ config, lib, ... }:
{
  imports = [
    ./amd.nix
    # ./intel.nix
    # ./nvidia.nix
  ];
  options.core.gpu = lib.mkOption {
    type = lib.types.enum [
      "amd"
      "none"
    ] # ++ [ "intel" "nvidia" ]
    ;
    default = "none";
    example = "amd";
    description = "Sets the GPU driver.";
  };
}
