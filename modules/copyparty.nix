{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  networking.firewall.allowedTCPPorts = [ 3923 ];
  networking.firewall.allowedUDPPorts = [ 3923 ];

  services.copyparty = {
    enable = true;

    settings = {
      i = "0.0.0.0";

      dedup = true;
      e2dsa = true;
      e2ts = true;
      reflink = true;
    };

    accounts = {
      noob.passwordFile = "/home/danielgu/.config/copyparty/.pw_noob";
    };

    volumes."/" = {
      path = "/srv/copyparty";

      access.A = [ "noob" ];

      flags.scan = 60 * 5;
    };

    volumes."/adx-converts" = {
      path = "/srv/copyparty/adx-converts";

      access.r = "*";
      access.A = [ "noob" ];
    };

    volumes."/tmp" = {
      path = "/srv/copyparty/tmp";

      access.wG = "*";
      access.A = [ "noob" ];

      flags = {
        fk = 4;
        sz = "0b-100m";
        d2t = true;
        lifetime = 60 * 60;
      };
    };

    volumes."/share" = {
      path = "/srv/copyparty/share";

      access.rg = "*";
      access.A = [ "noob" ];

      flags = {
        d2t = true;
        lifetime = 60 * 60;
      };
    };

    openFilesLimit = 8192;
  };
}
