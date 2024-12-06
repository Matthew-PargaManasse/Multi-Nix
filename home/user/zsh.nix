{ config, lib, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
#    initExtra = "source ~/.p10k.zsh"; #new

    shellAliases = {
      ls = "eza --icons";
      "ls -lah" = "eza -1la";
      update = "sudo nix flake update && sudo nixos-rebuild switch --flake ./#nixos";
      cat = "bat";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
#    plugins = [
#      {
#        name = "powerlevel10k";
#        src = pkgs.zsh-powerlevel10k;
#        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
#      }
#   ];

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        #{ name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    oh-my-zsh = {
     enable = true;
     plugins = [ "web-search" "kitty" "nmap" "tailscale" ];
     #theme = "fino-time";
    };
  };

}
