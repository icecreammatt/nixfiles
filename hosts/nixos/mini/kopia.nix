{
  pkgs,
  config,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [
    kopia
  ];

  sops.secrets."kopia/PASSWORD" = {
    sopsFile = ../../../.secrets/kopia.ini;
    format = "ini";
  };

  sops.secrets."kopia/USERNAME" = {
    sopsFile = ../../../.secrets/kopia.ini;
    format = "ini";
  };

  systemd.services.kopia = {
    enable = true;
    description = "kopia";
    serviceConfig = {
      ExecStart = "${pkgs.kopia}/bin/kopia server start --insecure --server-username $USERNAME --server-password $PASSWORD";
      Type = "simple";
      User = user;
      Group = "users";
      EnvironmentFile = [
        config.sops.secrets."kopia/PASSWORD".path
        config.sops.secrets."kopia/USERNAME".path
      ];
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = ["multi-user.target"];
  };
}
