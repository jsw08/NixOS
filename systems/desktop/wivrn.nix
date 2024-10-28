{
  config,
  pkgs,
  lib,
  ...
}: {
  services.wivrn = {
    enable = true;
    openFirewall = true;
    extraPackages = [ pkgs.wlx-overlay-s ];
  };
}
