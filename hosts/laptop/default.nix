{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/base.nix
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  networking.hostName = "laptop";

  # LUKS Encryption (Uncomment and replace FILLER-UUID if using LUKS)
  # boot.initrd.luks.devices."luks-FILLER-UUID".device = "/dev/disk/by-uuid/FILLER-UUID";

  # Graphics and Nvidia Configuration
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
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
    domains = ["~."];
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

  # Nix garbage collection (managed by nh now)
  nix.optimise.automatic = true;

  # Power Management
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        energy_performance_preference = "balance_power";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        energy_performance_preference = "performance";
        turbo = "auto";
      };
    };
  };

  # Define system users
  users.users.mitch = {
    isNormalUser = true;
    description = "mitch";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };

  users.users.mitch-daily = {
    isNormalUser = true;
    description = "Daily Tasks and Privacy";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };

  users.users.mitch-embedded = {
    isNormalUser = true;
    description = "Embedded Systems Exploitation";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "dialout" "plugdev"];
  };

  system.stateVersion = "24.05";
}
