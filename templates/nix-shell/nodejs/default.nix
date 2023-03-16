with import <nixpkgs> {};

# Use this site to get different build hashes for nodejs versions
# https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=nodejs
let
  # Node 16.13.1
  pkgsNode = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz";
  }) {};
  node = pkgsNode.nodejs;

  # Nginx 1.21.6
  pkgsNginx = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bf972dc380f36a3bf83db052380e55f0eaa7dcb6.tar.gz";
  }) {};
  nginx = pkgsNginx.nginxMainline;

in
stdenv.mkDerivation {
  name = "node-16.13.1";

  buildInputs = [
    node 
    nginx
  ];

  shellHook = ''
    # export PATH="$PWD/node_modules/.bin/:$PATH"
    #pnpm setup

    mkdir -p  ~/.pnpm-home
    export PATH=~/.pnpm-home/:$PATH
    pnpm setup
    pnpm link --global

    alias port="lsof -i -P -n | grep -E \"(COMMAND|node|nginx)\"";

    corepack enable

    # export prefix=~/.npm

    # pnpm i # run this once manually or it will lag for each window
  '';
}
