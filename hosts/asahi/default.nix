{
  inputs,
  nixpkgs,
  helix-flake,
  sops-nix,
  home-manager,
  ...
}: let
  user = "matt";
  userName = "matt";

  # Setup Asahi Architecture
  system = "aarch64-linux";

  pkgs = import nixpkgs {
    inherit system;

    # Allow packages like Nvidia Drivers
    config.allowUnfree = true;

    # Import overlays defined in the root directory overlay config
    overlays = [
      (import ../../overlay/overlay.nix)
    ];
  };

  # Wrap yazi so images work
  yazi = pkgs.symlinkJoin {
    name = "yazi-wrapped";
    paths = [pkgs.yazi];
    nativeBuildInputs = [pkgs.makeBinaryWrapper];
    postBuild = ''
      wrapProgram "$out/bin/yazi" --set TERM_PROGRAM "WezTerm"
    '';
  };
in {
  # M1 Macbook Pro + Asahi Linux Configuration
  asahi = home-manager.lib.homeManagerConfiguration {
    # This is duplicated here for home manager
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (import ../../overlay/overlay.nix)
      ];
    };

    extraSpecialArgs = {inherit inputs user pkgs;};
    modules = [
      ../../modules/options.nix
      ../../modules/common.nix
      sops-nix.homeManagerModule
      {
        sops.defaultSopsFormat = "yaml";
        sops.age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
      }
      {
        # override home manager helix with my fork
        programs.helix.package = helix-flake.packages."${pkgs.system}".default;
        programs.helix.enable = true;
      }

      # ../../modules/common-linux-gui.nix
      ../../modules/shell/gitui.nix
      ../../modules/shell/starship.nix
      ../../modules/rust.nix
      # ../../modules/keyboard-dev.nix
      {
        home = {
          username = "${userName}";
          homeDirectory = "/home/${userName}";

          # alias wl-copy to pbcopy and pbpaste
          file."bin/pbcopy".source = "${pkgs.wl-clipboard}/bin/wl-copy";
          file."bin/pbpaste".source = "${pkgs.wl-clipboard}/bin/wl-paste";

          # CapabilityBoundingSet=CAP_NET_ADMIN
          # AmbientCapabilities=CAP_NET_ADMIN
          # Running this as root is not idea but I cannot get the Set Cap bits to work
          file.".config/systemd/system/nebula.service".text = ''
            [Unit]
            Description=Nebula Service
            After=network.target
            StartLimitIntervalSec=0

            [Service]
            Restart=always
            Type=simple
            Restart=always
            RestartSec=1
            User=root
            ExecStart=${pkgs.nebula}/bin/nebula -config /etc/nebula/config.yaml

            [Install]
            WantedBy = ["multi-user.target"];
          '';

          packages = [
            pkgs.cascadia-code # Fonts
            pkgs.docker
            pkgs.hex2color # CLI color display
            pkgs.home-manager # Used for managing files and programs in home directory
            pkgs.pocketbase
            # pkgs.lilypond-with-fonts # Sheet Music
            pkgs.sops
            pkgs.nerdfonts # Fonts
            pkgs.nmap # Network Debugging tool
            pkgs.nodejs_20
            pkgs.sublime-merge
            # pkgs.wezterm        # The Best Terminal // Use pacman verion that doesn't crash for Asahi
            pkgs.which # Determine where processes are
            pkgs.wl-clipboard # Command-line copy/paste utilities for Wayland
            pkgs.waypipe
            yazi
            inputs.worm.packages."aarch64-linux".default
            pkgs.zk
          ];
          stateVersion = "23.05";
        };
      }
    ];
  };
}
