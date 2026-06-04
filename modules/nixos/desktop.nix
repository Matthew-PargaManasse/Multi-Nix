{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Display Manager: SDDM (ML4W standard)
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; # Required for clean handoff to Hyprland on Intel
  services.displayManager.sddm.package = pkgs.kdePackages.sddm;
  services.displayManager.sddm.theme = "sddm-astronaut-theme";
  services.displayManager.sddm.extraPackages = with pkgs.kdePackages; [
    qtsvg
    qtmultimedia
    qtvirtualkeyboard
  ];

  # Window Manager: Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Virtualization: VirtualBox
  # Temporarily disabled: VirtualBox DKMS modules are known to break DRM/Wayland on bleeding edge kernels.
  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   enableExtensionPack = true;
  # };
  users.extraGroups.vboxusers.members = [ "mitch" "mitch-daily" "mitch-embedded" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Sound (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Stylix Configuration
  stylix.enable = true;
  stylix.image = ../../wallpapers/ml4w_tokyonight.jpg;
  stylix.polarity = "dark";
  
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    monospace = {
      package = pkgs.nerd-fonts.meslo-lg;
      name = "MesloLGS Nerd Font Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
    sizes = {
      terminal = 10;
      applications = 10;
    };
  };

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Common desktop packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    pamixer
    blueman
    networkmanagerapplet
    wl-clipboard
    spotify
    sddm-astronaut
    seahorse # GUI for managing the keyring
  ];

  # Enable GNOME Keyring for saving passwords (fixes Antigravity IDE logging out)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enterprise policies to harden Brave and remove bloatware (Wallet, Leo AI, etc.)
  environment.etc."brave/policies/managed/extra.json".text = builtins.toJSON {
    BraveWalletDisabled = true;
    BraveRewardsDisabled = true;
    BraveAIChatEnabled = false;
    BraveVPNDisabled = true;
    BraveNewsDisabled = true;
    BraveTalkDisabled = true;
    BackgroundModeEnabled = false;
    MetricsReportingEnabled = false;
  };
}
