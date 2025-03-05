{
  self,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
    ../../modules/kanata
    ../common.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS VCam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.hosts = {
    "192.168.100.200" = ["pzn.local"];
    "192.168.100.1" = ["ddwrt.local"];
    "223.166.245.202" = ["home"];
  };

  time.timeZone = "Asia/Shanghai";
  time.hardwareClockInLocalTime = true;

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

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-rime
      fcitx5-hangul
    ];
  };

  # X11/GNOME
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    #wacom.enable = true;

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  services.displayManager.defaultSession = "gnome-xorg";

  services.libinput.mouse = {
    accelProfile = "flat";
    middleEmulation = false;
    scrollButton = 3;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono NFM"];
      sansSerif = ["Inter" "Noto Sans CJK SC" "Noto Sans CJK KR" "Noto Sans CJK JP"];
      serif = ["DejaVu Serif" "Noto Serif CJK SC" "Noto Serif CJK KR" "Noto Serif CJK JP"];
    };
    fontDir.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [epson-escpr];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Pipewire sound
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  programs.noisetorch.enable = true;
  programs.dconf.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  users.users.danielgu = {
    isNormalUser = true;
    description = "Daniel Gu";
    extraGroups = ["networkmanager" "wheel" "audio"];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = {inherit self inputs;};
    users = {
      "danielgu" = import ./home.nix;
    };
  };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  #services.udev.extraRules = "";

  environment.systemPackages = with pkgs; [
    wget
    unzip
    xclip
    nushell
  ];
  environment.variables = {
    MOZ_ENABLE_WAYLAND = 0;
    # https://github.com/Martichou/rquickshare/issues/158
    WEBKIT_DISABLE_COMPOSITING_MODE = 1;
  };
  environment.shells = [
    "/run/current-system/sw/bin/nu"
    "${pkgs.nushell}/bin/nu"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    libxkbcommon
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  # services.jack = {
  #   jackd.enable = true;
  #   alsa.enable = true;
  # };

  services.openssh.enable = true;

  services.hardware.openrgb.enable = true;

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "daily";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
