{ config, pkgs, inputs, ... }:

{
  imports = [
    ./common/zsh.nix
    ./common/neovim
    ./common/theme.nix
    ./common/hyprland.nix
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bat
    btop
    eza
    fastfetch
    flameshot
    fmt
    fzf
    kitty
    mlocate
    obsidian
    pipewire
    pkg-config
    ripgrep
    terminator
    wget
    waybar
    rofi
    dunst
    font-awesome
    font-awesome_4
    font-awesome_5
    tokyonight-gtk-theme
    gnome-tweaks
  ];

  home.sessionVariables = {
     EDITOR = "nvim";
     GTK_THEME = "Tokyonight-Dark-B";
  };

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
