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
    initContent = ''
      fastfetch
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
