{  pkgs, lib, ... }:

with import <nixpkgs> {};

let

    # pkgs = import (builtins.fetchTarball {
    #     url = "https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz";
    # }) {};

    # myPkg = pkgs.nodejs;

    # builtins.currentSystem = "darwin";
    # Node 16.13.1
    pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz";
      sha256 = "13s8g6p0gzpa1q6mwc2fj2v451dsars67m4mwciimgfwhdlxx0bk";
    }) {};
    nodejs16 = pkgs.nodejs;
in
{
  home.packages = [
    nodejs16
    # nodePackages.typescript-language-server
    # nodePackages.pnpm
  ];
}
