{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline neo-tree-nvim lspsaga-nvim telescope-fzf-native-nvim ];
    extraLuaConfig = ''
      vim.cmd([[
          set autoindent expandtab tabstop=2 shiftwidth=2"
          set number relativenumber

          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope live_grep<cr>
          nnoremap <leader>fb <cmd>Telescope buffers<cr>
          nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      ]])
      neotreeConfig = {
        use_libuv_file_watcher = true;
        follow_current_file = { enabled = true; };
      }
    require('neo-tree').setup(neotreeConfig)
      '';
    vimAlias = true;
    viAlias = true;
  };
               }
