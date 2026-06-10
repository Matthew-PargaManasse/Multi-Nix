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
    ./common/wallust.nix
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
    
    # Basic Desktop Utilities
    gnome-text-editor
    gnome-calculator
    evince
    file-roller
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/svg+xml" = [ "imv.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];
      "text/markdown" = [ "org.gnome.TextEditor.desktop" ];
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
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
