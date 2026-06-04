{
  programs.nixvim.plugins.bufferline = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    { mode = "n"; key = "<TAB>"; action = ":BufferLineCycleNext<CR>"; options.silent = true; }
    { mode = "n"; key = "<S-TAB>"; action = ":BufferLineCyclePrev<CR>"; options.silent = true; }
    { mode = "n"; key = "<C-w>"; action = ":bdelete<CR>"; options.silent = true; }
  ];
}
