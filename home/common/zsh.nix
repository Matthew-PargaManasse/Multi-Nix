{ config, lib, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      fastfetch
    '';

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -1la";
      update = "sudo nix flake update && sudo nixos-rebuild switch --flake ./#nixos";
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
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
    oh-my-zsh = {
     enable = true;
     plugins = [ "web-search" "kitty" "nmap" "tailscale" ];
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
  };

  home.packages = with pkgs; [
    fastfetch
  ];

}
