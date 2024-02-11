{pkgs, ...}: {
  systemd.services.nebula = {
    enable = true;
    description = "nebula";
    serviceConfig = {
      ExecStart = "${pkgs.nebula}/bin/nebula -config /etc/nebula/config.yaml";
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = ["multi-user.target"];
  };
}
