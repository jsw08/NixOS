{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop.type != "none";
in
{
  config = lib.mkIf cfg {
    sound.enable = lib.mkForce false;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    environment.systemPackages = with pkgs; [
      pulsemixer
      playerctl
    ];
  };
}