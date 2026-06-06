{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Bootloader setup (common for UEFI)
  boot.loader.systemd-boot.enable = pkgs.lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = pkgs.lib.mkDefault true;

  # Enable networking (NetworkManager)
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
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

  # Enable ZSH
  programs.zsh.enable = true;
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Essential services
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.dbus.implementation = "broker";


  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable nh (Nix Helper)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 30d --keep 5";
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # Existing packages
    arp-scan
    blueman
    brightnessctl
    cmake
    ethtool
    fping
    git
    home-manager
    lshw
    netcat-openbsd
    netdiscover
    networkmanagerapplet
    pciutils
    plocate
    python3
    tailscale
    unzip
    usbutils
    uv
    vim
    wget
    zsh
    moonlight-qt

    # Common Ubuntu/Standard Linux Utilities
    curl
    file
    jq
    psmisc # provides killall
    lm_sensors # provides sensors
    lsof
    nmap
    rsync
    socat
    strace
    sysstat
    tcpdump
    tree

    # Modern Rust/Go CLI Replacements
    doggo # replaces dnsutils/dig
    duf # replaces df
    dust # replaces du
    fd # replaces find
    procs # replaces ps
    tealdeer # fast tldr client
    zellij # replaces tmux
  ];

  environment.variables.EDITOR = "nvim";

  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    font-awesome
  ];

  # Firmware updates (Disabled due to LVFS auth timeout failing the build)
  services.fwupd.enable = false;

  # Required by Home Manager for Desktop Environments
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  system.stateVersion = "24.05";
}
