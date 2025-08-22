{ pkgs, security, ... }: {
  security.wrappers.tlpstat = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "/etc/tlp-stat-wrapper.sh";
    };

  systemd.tmpfiles.rules = [ "f /etc/tlp-stat-wrapper.sh 4511 root root 10d #!/run/current-system/sw/bin/env sh\n -c \"tlp-stat -b\"" ];

                         }
