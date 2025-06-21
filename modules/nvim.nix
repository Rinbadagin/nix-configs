{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline neo-tree-nvim lspsaga-nvim telescope-fzf-native-nvim ];
    extraConfig = ''
      set autoindent expandtab tabstop=2 shiftwidth=2
      set number relativenumber

      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      '';
    vimAlias = true;
    viAlias = true;
  };
               }
