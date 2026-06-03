{ config, pkgs, ... }:

{
  imports = [
    ../../modules/nixos/base.nix
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  networking.hostName = "laptop";

  boot.initrd.luks.devices."luks-5cd87e8a-61fc-411e-b3d8-c316b8edcc3a".device = "/dev/disk/by-uuid/5cd87e8a-61fc-411e-b3d8-c316b8edcc3a";

  # Graphics and Nvidia Configuration
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };
  };

  # Network specific options
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
        "9.9.9.9"
        "149.112.112.112"
    ];
    dnsovertls = "true";
  };

  # Custom tailscale routing script from previous config
  services.tailscale.interfaceName = "userspace-networking";
  services.tailscale.useRoutingFeatures = "both";
  services.networkd-dispatcher = {
    enable = true;
    rules."50.tailscale" = {
        onState = ["routable"];
        script = ''
            ${pkgs.ethtool}/bin/ethtool -K enp5s0f3u1u4u4 rx-udp-gro-forwarding on rx-gro-list off
        '';
    };
  };
  networking.firewall.checkReversePath = "loose";

  # Nix garbage collection
  nix.gc = {
    automatic = true;
    dates = "03:15";
    options = "-delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  # Define system users
  users.users.mitch = {
    isNormalUser = true;
    description = "mitch";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.mitch-daily = {
    isNormalUser = true;
    description = "Daily Tasks and Privacy";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.mitch-embedded = {
    isNormalUser = true;
    description = "Embedded Systems Exploitation";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" ];
  };

  system.stateVersion = "24.05";
}
