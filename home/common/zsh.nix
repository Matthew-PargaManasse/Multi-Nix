{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      fastfetch

      # Modern CLI Intercepts
      function tmux() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mzellij\033[0m instead of tmux..."; zellij "$@"; }
      function du() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mdust\033[0m instead of du..."; dust "$@"; }
      function df() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mduf\033[0m instead of df..."; duf "$@"; }
      function find() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mfd\033[0m instead of find..."; fd "$@"; }
      function ps() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mprocs\033[0m instead of ps..."; procs "$@"; }
      function dig() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mdoggo\033[0m instead of dig..."; doggo "$@"; }
      function man() { echo -e "\033[1;33m[Notice]\033[0m Running modern equivalent \033[1;32mtealdeer (tldr)\033[0m instead of man..."; tldr "$@"; }
    '';

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -lh --icons";
      lah = "eza -lah --icons";
      update = "sudo nix flake update && sudo nixos-rebuild switch --flake ./#$(hostname)";
      cat = "bat";
      cd = "z";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["web-search" "kitty" "nmap" "tailscale"];
    };
  };

  # Modern Rust/C CLI replacements
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  # Override Yazi's desktop file so Rofi launches it with a larger font in Kitty
  xdg.desktopEntries.yazi = {
    name = "Yazi";
    genericName = "File Manager";
    exec = "kitty -o font_size=16 -e yazi %u";
    terminal = false; # We launch Kitty ourselves
    categories = ["Utility" "Core" "System" "FileTools" "FileManager"];
    icon = "system-file-manager";
  };

  home.packages = with pkgs; [
    fastfetch
  ];


}
