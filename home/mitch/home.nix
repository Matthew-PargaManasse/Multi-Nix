{ config, pkgs, inputs, ... }:
{
  imports = [
    ./zsh.nix
    ./neovim
    ./theme.nix
    ./brave.nix
    ./flameshot.nix
  ];

  home.username = "mitch";
  home.homeDirectory = "/home/mitch";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    aircrack-ng
    bat
    btop
    vim
    wget
    brave
    burpsuite
    element-desktop
    eza
    flameshot
    fmt
    fzf
    gimp
    kitty
    metasploit
    mlocate
    fastfetch
    neovim
    obsidian
    pipewire
    pkg-config
    protonmail-bridge
    protonvpn-gui
    ripgrep
    signal-desktop
    slack
    terminator
    thunderbird
    virt-viewer
    virtualbox
    virtualboxWithExtpack
    font-awesome
    font-awesome_4
    font-awesome_5
    tokyonight-gtk-theme
    haskellPackages.font-awesome-type
    gnome-tweaks
    gparted
    ];


  home.file =  {};

  home.sessionVariables = {
     EDITOR = "nvim";
     GTK_THEME = "Tokyonight-Dark-B";
  };


  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Matthew-PargaManasse";
    userEmail = "LithoBreakerGB@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

}
