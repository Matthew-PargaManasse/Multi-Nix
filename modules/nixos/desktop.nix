{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Display Manager: SDDM (ML4W standard)
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Sound (Pipewire)
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Stylix Configuration
  stylix.enable = true;
  stylix.image = ../../wallpapers/ml4w_tokyonight.png;
  stylix.polarity = "dark";
  
  # Disable Stylix wallpaper engines so wpaperd can handle dynamic backgrounds without conflicting
  stylix.targets.hyprland.hyprpaper.enable = false;
  stylix.targets.swaybg.enable = false;
  
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
      package = pkgs.noto-fonts-emoji;
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
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
