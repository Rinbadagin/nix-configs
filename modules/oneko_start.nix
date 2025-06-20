{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    oneko
  ];

  systemd.user.services.oneko = {
      description = "Oneko server cat :3";

      wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      type = "simple";
      environment = "WAYLAND_DISPLAY=wayland-0";
      # Environment = "PATH=/run/wrappers/bin:/etc/profiles/per-user/root/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
      execStart = "${pkgs.oneko}/bin/oneko";
      remainAfterExit = true;
    };
  };
}

