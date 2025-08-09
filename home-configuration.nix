{ config, pkgs, lib, ... }:
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

    home.file."./.config/sway/config" = {
      # from: https://slar.se/configuring-touchpad-in-sway.html
      # swaymsg -t get_inputs is handy here
      text = ''
        include /etc/sway/config
        input "type:touchpad" {
          dwt disabled
          dwtp disabled
          tap enabled
          tap_button_map lrm
        }

        output eDP-1 {
          background /etc/nixos/backgrounds/castle.png fill
        }

        set $opacity 0.9
        gaps inner 5
        shadows enable
        blur enable
        corner_radius 8

        exec swayosd-server

        # Volume raise with max value
        bindsym XF86AudioRaiseVolume exec swayosd-client --output-volume raise --max-volume 120
        # Volume lower with max value
        bindsym XF86AudioLowerVolume exec swayosd-client --output-volume lower --max-volume 120
				
				# Volume raise with max value
				bindsym XF86AudioRaiseVolume exec swayosd-client --output-volume raise --max-volume 120
				# Volume lower with max value
				bindsym XF86AudioLowerVolume exec swayosd-client --output-volume lower --max-volume 120
      '';
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
        background_opacity 0.7
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
        '';
      shellAliases = {
        editnix = "/etc/nixos/scripts/editnix.zsh";
        tess = "f(){tesseract -l eng $@ | echo}f";
        note = "mkdir -p ~/notes/ && vim ~/notes/";
        proxyme = "sshuttle -r u0_a456@192.168.239.153:8022 0/0";
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
