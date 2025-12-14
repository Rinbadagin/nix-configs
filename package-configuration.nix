{ config, pkgs, nixpkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  programs.steam.enable = true;
  programs.weylus = {
    enable = true;
    users = [ "klara" ];
    openFirewall = true;
  };
  services.flatpak.enable = true;
  services.blueman.enable = true;
  services.dictd = {
    enable = true;
    DBs = with pkgs.dictdDBs; [
      wordnet
        deu2eng
        eng2deu
    ];
  };


  # from https://raw.githubusercontent.com/cm-b2g/B2G/1230463/tools/51-android.rules
  # and https://sites.google.com/view/bananahackers/development/adb?authuser=0
  services.udev.extraRules = ''
  SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0664", GROUP="plugdev"
  '';

  programs.firefox = {
    enable = true;
  };
  programs.zsh.enable = true;

  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets."tailscale-authkey.age".path;
    extraUpFlags = [ "--login-server" "https://hs.fem.nz/" ];
  };


  services.logind.extraConfig = ''
# don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
    '';

  programs.kdeconnect = { enable = true; };

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
      tmux
      gimp
      libreoffice
      vulkan-tools
      intel-gpu-tools
      git
      deadbeef
      xorg.xbacklight
      prismlauncher
      file
      exiftool
      binwalk
      ghidra
      zsteg
      gdb
      wireshark
      tesseract
      anki
      ardour
      gnome-tweaks
      # kicad
      devenv
      ripgrep
      libremines
      mpvpaper
      vlc
      waytrogen
      chafa
      (callPackage ./derivations/hanabi.nix{}).hanabi
      gnomeExtensions.media-controls
      gnomeExtensions.desktop-clock
      gnomeExtensions.desktop-icons-ng-ding
      lutris
      # retroarch-full
      darktable
      lmms
      art
      zeal
      cockatrice
      transmission_4-qt
      jdk8
      jdk24
      sunshine
      wine
      krakatau2
      runelite
      bolt-launcher
      sshuttle
      runescape
      audacity
      activitywatch
      android-tools
      testdisk
      foremost
      libwacom
      krita
      grim
      slurp
      wl-clipboard
      mako
      oculante
      swayosd
      upower
      networkmanager
      kdePackages.ark
      inkscape
      libuv
      wl-clipboard
      nmap
      pcmanfm
      rclone
      signal-desktop
      jetbrains.idea-community
      obs-studio
      pavucontrol
      texstudio
      obs-studio
      qgis
      (flameshot.override { enableWlrSupport = true; })
      kdePackages.kdenlive
      vscodium
      wdisplays
      zoom-us
      compose2nix
      blender
      nixos-generators
      obsidian
      dive
      docker-compose
      moonlight-qt
# new_pkg
      (callPackage "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/pkgs/agenix.nix" {})
      ];
}
