{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    caddy
  ];

  services.caddy = {
    enable = true;

    extraConfig = ''
        :80 {
          encode gzip
          file_server

          handle_path /* {
            root * "/mnt/storage/webroot"
            file_server browse
          }
        }
    '';

    virtualHosts."bw-vpn.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /* {
          reverse_proxy localhost:8110
        }
    '';

    virtualHosts."rewind.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."woodpecker.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /* {
          reverse_proxy localhost:3007
        }
    '';

    virtualHosts."gitea.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /* {
          reverse_proxy localhost:3001
        }
    '';

    virtualHosts."hydra.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /* {
          reverse_proxy localhost:3000
        }
    '';

    virtualHosts."storybook-rewind.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:6006
        }
    '';

    virtualHosts."pocketbase-rewind.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /* {
          reverse_proxy localhost:8090
        }
    '';

    virtualHosts."rewind.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5174
        }
    '';

    virtualHosts."mini.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."k3s.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

        handle_path /* {
          reverse_proxy localhost:8001
        }
    '';
    
  };

}
