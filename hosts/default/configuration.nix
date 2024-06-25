# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

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
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-rime
      fcitx5-hangul
    ];
  };

  # X11
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.setupCommands = ''
    LEFT='DP-2'
    CENTER='DP-4'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --primary --pos 1080x240 --mode 2560x1440 --rate 144 --output $LEFT --mode 1920x1080 --rate 75 --rotate left
  '';
  services.xserver.desktopManager.gnome.enable = true;

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
      sansSerif = ["Inter" "Noto Sans CJK SC" "Noto Sans CJK KR" "Noto Sans CJK JP"];
      serif = ["DejaVu Serif" "Noto Serif CJK SC" "Noto Serif CJK KR" "Noto Serif CJK JP"];
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Pipewire sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.danielgu = {
    isNormalUser = true;
    description = "Daniel Gu";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
      obsidian
      slack
      # blender
      zotero
      zoom-us
      libreoffice
      anki-bin
      youtube-music
      obs-studio

      porsmo
      font-manager
      ffmpeg
      pandoc
      alejandra
      xclip

      jetbrains.pycharm-professional
      jetbrains.idea-ultimate
      jetbrains.clion
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "danielgu" = import ./home.nix;
    };
  };

  #hardware.opentabletdriver.enable = true;
  #services.udev.extraRules = "";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    gcc13

    rustup

    inter
  ];

  # Required for egui to work?? idk
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libxcb
    xorg.libXi
    libxkbcommon
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.openssh.enable = true;

  services.hardware.openrgb.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
