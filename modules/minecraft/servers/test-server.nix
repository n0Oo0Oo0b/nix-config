{ servers, ... }:
{
  enable = true;
  package = servers.fabric-1_21_3;
  openFirewall = true;
  serverProperties = {
    server-port = 25565;
    online-mode = true;
    view-distance = 8;
    motd = "hi";
  };
}
