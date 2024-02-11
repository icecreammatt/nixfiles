{pkgs, ...}: {
  services.vaultwarden.enable = true;
  services.vaultwarden.config = {
    ROCKET_ADDRESS = "127.0.0.1";
    ROCKET_PORT = 8110;
  };

  systemd.timers."vaultwarden-backup" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      Persistent = true;
      AccuracySec = "1min";
      OnCalendar = "*-*-* 04:00:00"; # Run at 4:00 AM daily
      Unit = "vaultwarden-backup.service";
    };
  };

  systemd.services."vaultwarden-backup" = {
    path = with pkgs; [sqlite];
    script = ''
      ${pkgs.sqlite}/bin/sqlite3 /var/lib/bitwarden_rs/db.sqlite3 ".backup '/mnt/storage/backup/vaultwarden/db-$(date '+%Y%m%d-%H%M').sqlite3'"
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
