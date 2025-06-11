{ config, pkgs, ... }:
{
  programs.steam.enable = true;
  programs.zsh.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     firefox
     tmux
     gimp
     libreoffice
     vulkan-tools
     intel-gpu-tools
     git
  ];
}
