{
  self,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # ./mc-servers
    ../common.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  security.polkit.enable = true;

  networking.hostName = "pzn";
  networking.networkmanager.enable = true;
  networking.hosts = {
    "192.168.100.200" = ["pzn.local"];
    "192.168.100.1" = ["ddwrt.local"];
    "223.166.245.202" = ["home"];
  };

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.pansternoob = {
    isNormalUser = true;
    description = "Panster Noob";
    extraGroups = [ "networkmanager" "wheel" "minecraft" ];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = {inherit self inputs;};
    users = {
      "pansternoob" = import ./home.nix;
    };
    backupFileExtension = "bak";
  };

  services.openssh.enable = true;

  services.immich = {
    enable = true;
    host = "192.168.100.200";
    openFirewall = true;
    settings = null;
  };

  environment.systemPackages = with pkgs; [
    wget
    unzip
    xclip
    nushell
  ];
  environment.enableAllTerminfo = true;
  environment.shells = [
    "/run/current-system/sw/bin/nu"
    "${pkgs.nushell}/bin/nu"
  ];

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  system.stateVersion = "23.11";
}
