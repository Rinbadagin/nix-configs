{ config, pkgs, ...}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.klara = {
    isNormalUser = true;
    description = "Klara";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}
