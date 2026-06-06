{ pkgs, inputs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          number = true;
          relativenumber = true;
          signcolumn = "yes";
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        visuals.nvim-web-devicons.enable = true;
        autopairs.nvim-autopairs.enable = true;
        filetree.neo-tree.enable = true;

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        treesitter = {
          context.enable = true;
        };

        # Treesitter and LSP
        languages = {
          nix.enable = true;
          markdown.enable = true;
          python.enable = true;
          bash.enable = true;
        };

        # Utilities
        utility = {
          surround.enable = true;
        };

        notes = {
          neorg.enable = true;
        };

        # Keymaps
        keymaps = [
          { key = "<C-x>"; mode = "n"; action = ":close<CR>"; silent = true; }
          { key = "<C-s>"; mode = "n"; action = ":w<CR>"; silent = true; }
          { key = "<leader>s"; mode = "n"; action = ":w<CR>"; silent = true; }
          { key = "<esc>"; mode = "n"; action = ":noh<CR>"; silent = true; }
          { key = "Y"; mode = "n"; action = "y$"; silent = true; }
          { key = "<C-c>"; mode = "n"; action = ":b#<CR>"; silent = true; }
          { key = "<leader>h"; mode = "n"; action = "<C-w>h"; silent = true; }
          { key = "<leader>l"; mode = "n"; action = "<C-w>l"; silent = true; }
          { key = "L"; mode = "n"; action = "$"; silent = true; }
          { key = "H"; mode = "n"; action = "^"; silent = true; }
          { key = "<C-Up>"; mode = "n"; action = ":resize -2<CR>"; silent = true; }
          { key = "<C-Down>"; mode = "n"; action = ":resize +2<CR>"; silent = true; }
          { key = "<C-Left>"; mode = "n"; action = ":vertical resize +2<CR>"; silent = true; }
          { key = "<C-Right>"; mode = "n"; action = ":vertical resize -2<CR>"; silent = true; }
        ];
      };
    };
  };
}
