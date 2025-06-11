{ config, pkgs, ... }:
{
	programs.steam.enable = true;
	programs.firefox = {
		enable = true;
		package = pkgs.librewolf;
		policies = {
			DisableTelemetry = true;
			DisableFirefoxStudies = true;
			Preferences = {
				"cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
					"cookiebanners.service.mode" = 2; # Block cookie banners
					"privacy.donottrackheader.enabled" = true;
				"privacy.fingerprintingProtection" = true;
				"privacy.resistFingerprinting" = true;
				"privacy.trackingprotection.emailtracking.enabled" = true;
				"privacy.trackingprotection.enabled" = true;
				"privacy.trackingprotection.fingerprinting.enabled" = true;
				"privacy.trackingprotection.socialtracking.enabled" = true;
			};
			ExtensionSettings = {
				"jid1-ZAdIEUB7XOzOJw@jetpack" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
					installation_mode = "force_installed";
				};
				"uBlock0@raymondhill.net" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					installation_mode = "force_installed";
				};
			};
		};
	};
	programs.zsh.enable = true;

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
	];
}
