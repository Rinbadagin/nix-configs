{ config, pkgs, lib, security, ... }:
let
home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
      ./modules/oneko_start.nix
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.users.klara = {
    imports = [ ./modules/nvim.nix ];
    /* The home.stateVersion option does not have a default and must be set */

    home.file.".config/sway/config" = {
# from: https://slar.se/configuring-touchpad-in-sway.html
# swaymsg -t get_inputs is handy here
      text = ''
        include /etc/nixos/sway/config
      '';
    };

    home.file.".config/rclone/rclone.conf" = {
      text = ''
        [thenuc-dav]
        type = webdav
          pacer_min_sleep = 0.01ms
          url = http://the-nuc:3923
          vendor = owncloud
          '';
    };

    home.file.".config/personal-scripts/status.sh" = {
      text = ''
        #!/run/current-system/sw/bin/env bash
        bat=$(sudo tlp-stat -b | grep "Charge" | sed -rn "s/.*([0-9]{2}).*/\1/p")
        echo $bat% $(date +'%Y-%m-%d %X')
      '';
      executable = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      prefix = "^a";
    };
    programs.kitty = {
      enable = true;
      extraConfig = ''
        background_opacity 0.7
        enable_audio_bell no
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
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history.size = 1000000;
      initContent = lib.mkOrder 1500 ''
        source /etc/nixos/scripts/runtmux.zsh

        echo "Welcome to terminal-land! Here are your aliases for today:\n\teditnix, tess, note, proxyme, nucdav, vimc, neotreec, getweather.\n:3"
        '';
      shellAliases = {
        editnix = "/etc/nixos/scripts/editnix.zsh";
        tess = "f(){tesseract -l eng $@ | echo}f";
        note = "mkdir -p ~/notes/ && vim ~/notes/";
        proxyme = "sshuttle -r u0_a456@192.168.239.153:8022 0/0";
        nucdav = "rclone mount --vfs-cache-mode writes --dir-cache-time 5s thenuc-dav: ~/nuc";
        vimc = "firefox https://scthornton.github.io/cheatsheets/vim_cheatsheet/";
        neotreec = "firefox https://deepwiki.com/nvim-neo-tree/neo-tree.nvim/3.2-key-mappings";
        getweather = "firefox https://www.metservice.com/maps-radar/rain/forecast/3-days";
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
    imports = [ ./modules/nvim.nix ];
    home.stateVersion = "25.05";
  };
}
