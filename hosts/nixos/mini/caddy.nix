{pkgs, ...}: let
  domain = "c4er.com";
  tlsConfig = "tls /mnt/certs/c4er.com/c4er.com.crt /mnt/certs/c4er.com/c4er.com.key";
  reverse_proxy_string = (import ./caddy-helpers.nix).reverse_proxy_string;
in {
  environment.systemPackages = with pkgs; [
    caddy
  ];

  services.caddy = {
    enable = true;

    extraConfig = ''
      :443 {
        ${tlsConfig}

        encode gzip
        file_server

        handle_path /* {
          root * "/mnt/storage/webroot"
          file_server browse
        }
      }
    '';

    virtualHosts."901.${domain}".extraConfig = ''
      ${tlsConfig}

      handle_path /* {
        root * "/mnt/storage/webroot/901"
        file_server browse
      }
    '';

    virtualHosts."pool.${domain}".extraConfig = ''
      ${tlsConfig}

      handle_path /* {
        root * "/mnt/storage/webroot/pool"
        file_server browse
      }
    '';

    virtualHosts."zombies.${domain}".extraConfig = ''
      ${tlsConfig}

      handle_path /* {
        root * "/mnt/storage/godot/zombies"
        file_server browse
      }
    '';

    virtualHosts."wiki.${domain}".extraConfig = ''
      ${tlsConfig}

      handle_path /* {
        root * "/mnt/storage/webroot/wiki/result/www/"
        file_server browse
      }
    '';

    virtualHosts."excalidraw.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 8085}
    '';

    virtualHosts."llm.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 8086}
    '';

    virtualHosts."kopia.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 51515}
    '';

    virtualHosts."metube.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 8081}
    '';

    virtualHosts."quickweb.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 2015}
    '';

    virtualHosts."attic.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 8072}
    '';

    virtualHosts."immich.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 2283}
    '';

    # Silverbullet
    virtualHosts."notes.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 3071}
    '';

    virtualHosts."planka.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 3059}
    '';

    virtualHosts."music.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 4533}
    '';

    virtualHosts."bw-vpn.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 8110}
    '';

    virtualHosts."woodpecker.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 3007}
    '';

    virtualHosts."gitea.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 3001}
    '';

    virtualHosts."mirotalk.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 3002}
    '';

    virtualHosts."hydra.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 3050}
    '';

    virtualHosts."grafana.${domain}".extraConfig = ''
      ${tlsConfig}

      ${reverse_proxy_string 2342}
    '';

    virtualHosts."storybook-rewind.${domain}".extraConfig = ''
      encode gzip
      file_server
      ${tlsConfig}

      handle_path /media/* {
        root * "/mnt/storage/rewind"
        file_server browse
      }

      ${reverse_proxy_string 6006}
    '';

    virtualHosts."pocketbase-rewind.dev.${domain}".extraConfig = ''
      tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

      ${reverse_proxy_string 8090}
    '';

    virtualHosts."rewind.${domain}".extraConfig = ''
      encode gzip
      file_server
      ${tlsConfig}

      handle_path /media/* {
        root * "/mnt/storage/rewind"
        file_server browse
      }

      ${reverse_proxy_string 4173}
    '';

    virtualHosts."rewind.dev.${domain}".extraConfig = ''
      encode gzip
      file_server
      tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

      handle_path /media/* {
        root * "/mnt/storage/rewind"
        file_server browse
      }

      ${reverse_proxy_string 5174}
    '';

    virtualHosts."rewind-dev-mini.${domain}".extraConfig = ''
      encode gzip
      file_server
      tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem
      ${tlsConfig}

      handle_path /media/* {
        root * "/mnt/storage/rewind"
        file_server browse
      }

      ${reverse_proxy_string 5173}
    '';

    virtualHosts."gaming.dev.${domain}".extraConfig = ''
      encode gzip
      file_server
      tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

      handle_path /media/* {
        root * "/mnt/storage/rewind"
        file_server browse
      }

      ${reverse_proxy_string 5173}
    '';

    virtualHosts."k3s.dev.${domain}".extraConfig = ''
      tls /mnt/certs/dev.c4er.com/fullchain2.pem  /mnt/certs/dev.c4er.com/privkey2.pem

      ${reverse_proxy_string 8001}
    '';
  };
}
