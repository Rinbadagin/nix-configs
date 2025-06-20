{ config, pkgs, lib, ... }:
let
home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.users.klara = {
    /* The home.stateVersion option does not have a default and must be set */
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-airline neo-tree-nvim lspsaga-nvim telescope-fzf-native-nvim ];
      extraConfig = ''
        set autoindent expandtab tabstop=2 shiftwidth=2
        set number relativenumber
        '';
      vimAlias = true;
      viAlias = true;
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
    };
    programs.kitty = {
      enable = true;
      extraConfig = ''
        background_opacity 0.9
        '';
    };
    programs.git = {
      enable = true;
      userName = "Rinbadagin";
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history.size = 1000000;
      initContent = lib.mkOrder 1500 ''
        source /etc/nixos/scripts/runtmux.zsh
        '';
      shellAliases = {
        editnix = "/etc/nixos/scripts/editnix.zsh";
        tess = "f(){tesseract -l eng $@ | echo}f";
      };
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "aliases" "git" "colorize" ];
      };
    };
    home.stateVersion = "25.05";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  };
  home-manager.users.root = {
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-airline neo-tree-nvim lspsaga-nvim ];
      extraConfig = ''
        set autoindent expandtab tabstop=2 shiftwidth=2
        set number relativenumber
        '';
      vimAlias = true;
      viAlias = true;
    };
    home.stateVersion = "25.05";
  };
}
