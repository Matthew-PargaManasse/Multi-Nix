{ config, pkgs, inputs, ... }:
{
  imports = [
    ./zsh.nix
    ./theme.nix
    ./brave.nix
  ];

  home.username = "db";
  home.homeDirectory = "/home/db";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    aircrack-ng
    bat
    btop
    vim
    wget
    brave
    eza
    flameshot
    fmt
    fzf
    gimp
    kitty
    mlocate
    obsidian
    pipewire
    pkg-config
    ripgrep
    signal-desktop
    thunderbird
    virt-viewer
    virtualbox
    virtualboxWithExtpack
    gnome-tweaks
    gparted
    ];


  home.file =  {};

  home.sessionVariables = {
     EDITOR = "vim";
  };



  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

    #  programs.git = {
    #    enable = true;
    #    userName = "Matthew-PargaManasse";
    #    userEmail = "LithoBreakerGB@gmail.com";
    #    extraConfig = {
    #      init.defaultBranch = "main";
    #      safe.directory = "/etc/nixos";
    #    };
    #  };

}
