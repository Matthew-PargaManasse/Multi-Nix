{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./common/zsh.nix
    ./common/nvf.nix
    ./common/theme.nix
    ./common/hyprland.nix
    ./common/brave.nix
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
    settings = {
      user = {
        name = "Matthew-PargaManasse";
        email = "LithoBreakerGB@gmail.com";
      };
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
