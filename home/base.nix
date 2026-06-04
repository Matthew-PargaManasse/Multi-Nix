{
  config,
  pkgs,
  inputs,
  ...
}: {
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
    fzf
    kitty
    obsidian
    ripgrep
    wget
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
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
