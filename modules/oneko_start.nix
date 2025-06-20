{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    oneko
  ];

  systemd.user.services.oneko = {
      description = "Oneko server cat :3";

      wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      # Environment = "PATH=/run/wrappers/bin:/etc/profiles/per-user/root/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
      ExecStart = "${pkgs.oneko}/bin/oneko";
      RemainAfterExit = true;
    };
  };
}

