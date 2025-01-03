{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop.type != "none";
  usr = config.core.username;
  mkForceInstalled = extensions:
    builtins.mapAttrs
    (name: url: {
      installation_mode = "force_installed";
      "install_url" = url;
    })
    extensions;
in {
  config.home-manager.users.${usr}.programs.firefox = {
    enable = cfg;
    profiles.${usr} = {
      settings = {
        "apz.overscroll.enabled" = true;
        "browser.aboutConfig.showWarning" = false;
        "general.autoScroll" = true;
      };
    };
    policies = {
      BlockAboutConfig = true;
      ExtensionSettings = mkForceInstalled {
        "uBlock0@raymondhill.net" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        "DontFuckWithPaste@raim.ist" = "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
        "sponsorBlocker@ajay.app" = "https://addons.mozilla.org/firefox/downloads/file/4047157/sponsorblock-5.1.11.xpi";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      };
    };
  };
}
