{
  services.openssh = {
    enable = true;
    #openFirwall = true;
    settings.PrintMotd = true;
    startWhenNeeded = true;
  };
}
