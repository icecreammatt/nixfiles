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

    virtualHosts."mini.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."dev.rewind.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/rewind.c4er.com/fullchain1.pem  /mnt/certs/rewind.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."rewind.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/rewind.c4er.com/fullchain1.pem  /mnt/certs/rewind.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."storybook.rewind.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/rewind.c4er.com/fullchain1.pem  /mnt/certs/rewind.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:6006
        }
    '';

    virtualHosts."mini-vpn.dev.c4er.com".extraConfig = ''
        encode gzip
        file_server
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /media/* {
          root * "/mnt/storage/rewind"
          file_server browse
        }

        handle_path /* {
          reverse_proxy localhost:5173
        }
    '';

    virtualHosts."bw-vpn.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8000
        }
    '';

    virtualHosts."bw-vpn.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8000
        }
    '';

    virtualHosts."bw.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8000
        }
    '';

    virtualHosts."pocketbase.rewind.c4er.com".extraConfig = ''
        tls /mnt/certs/rewind.c4er.com/fullchain1.pem  /mnt/certs/rewind.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8090
        }
    '';

    virtualHosts."k3s.dev.c4er.com".extraConfig = ''
        tls /mnt/certs/dev.c4er.com/fullchain1.pem  /mnt/certs/dev.c4er.com/privkey1.pem

        handle_path /* {
          reverse_proxy localhost:8001
        }
    '';
    
  };

}
