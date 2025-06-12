{ config, pkgs, ...}:
{
  users.users.klara = {
    isNormalUser = true;
    description = "Klara";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
# Managed by home-manager - do we need this?
    ];
  };
}
