{ config, lib, pkgs, inputs, ...}:
{

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ nerdtree nerdtree-git-plugin vim-nerdtree-syntax-highlight vim-nerdtree-tabs deoplete-zsh ];
  };  

}
