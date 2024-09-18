{
    services.tailscale = {
        enable = true;
        openFirewall = true;
        # extraUpFlags = ["--ssh"]; #TODO: Only works with authkey.
    };
}