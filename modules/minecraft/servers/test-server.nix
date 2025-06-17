{ servers, ... }:
{
  enable = false;
  package = servers.fabric-1_20_4;
  openFirewall = true;
  serverProperties = {
    server-port = 25565;
    online-mode = false;
    motd = "hi";
  };
}
