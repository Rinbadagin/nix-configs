{ config, pkgs, ... }:
{
	programs.steam.enable = true;
	programs.firefox.enable = true;
	programs.zsh.enable = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		wget
			firefox
			tmux
			gimp
			libreoffice
			vulkan-tools
			intel-gpu-tools
			git
			deadbeef
	];
}
