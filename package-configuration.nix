{ config, pkgs, ... }:
{
  programs.steam.enable = true;
  programs.firefox = {
    enable = true;
    #package = pkgs.librewolf;
    #policies = {
    #  DisableTelemetry = true;
    #  DisableFirefoxStudies = true;
    #  Preferences = {
    #    "webgl.disabled" = false;
    #    "privacy.resistFingerprinting" = false;
    #    "privacy.clearOnShutdown.history" = false;
    #    "privacy.clearOnShutdown.cookies" = false;
    #    "network.cookie.lifetimePolicy" = 0;
    #  };
    #  ExtensionSettings = {
    #    "jid1-ZAdIEUB7XOzOJw@jetpack" = {
    ##      install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
    #      installation_mode = "force_installed";
    #    };
    #    "uBlock0@raymondhill.net" = {
    #      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    #      installation_mode = "force_installed";
    #    };
    #  };
    #};
  };
  programs.zsh.enable = true;

  services.tailscale.enable = true; 

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
      kicad
      kdePackages.kdeconnect-kde
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
      # new_pkg
      ];
}
