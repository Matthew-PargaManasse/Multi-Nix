{ config, pkgs, inputs, ... }:
{
  imports = [
    ./zsh.nix
    #./vim.nix
    ./neovim
    ./theme.nix   
    ./brave.nix
  ];

  home.username = "mitch";
  home.homeDirectory = "/home/mitch";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
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
