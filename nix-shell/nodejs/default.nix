with import <nixpkgs> {};

let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz";
  }) {};
  myPkg = pkgs.nodejs;
in
stdenv.mkDerivation {
  name = "node-16.13.1";

  buildInputs = [
    myPkg
  ];

  shellHook = ''
    # export PATH="$PWD/node_modules/.bin/:$PATH"
    pnpm setup

    export prefix=~/.npm
    # one time is needed: cd packages/tooling-solo-scripts && pnpm link --global

    corepack enable

    # pnpm i # run this manually or it will lag for each window
  '';
}
