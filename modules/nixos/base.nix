{ config, pkgs, inputs, ... }:

{
  # Bootloader setup (common for UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    home-manager
    arp-scan
    blueman
    brightnessctl
    cmake
    ethtool
    fping
    git
    lshw
    mlocate
    netcat
    netdiscover
    networkmanagerapplet
    pciutils
    python311
    python311Packages.pip
    tailscale
    unzip
    usbutils
  ];

  environment.variables.EDITOR = "nvim";

  fonts.packages = with pkgs; [
    meslo-lgs-nf
    nerd-fonts.meslo-lg
    font-awesome
    font-awesome_4
    font-awesome_5
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Enable Firmware updates
  services.fwupd.enable = true;

  system.stateVersion = "24.05";
}
