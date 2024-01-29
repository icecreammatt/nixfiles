# nodejs version 16.13.1
{pkgs, ...}: let
  system = "x86_64-darwin"; # Todo see how to pass this through from parent
  # version = "16.13.1"; <-- this is for refence for the build sha below
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz";
    sha256 = "13s8g6p0gzpa1q6mwc2fj2v451dsars67m4mwciimgfwhdlxx0bk";
  }) {inherit system;};

  node16 = pkgs.nodejs;
in {
  home.packages = with pkgs; [
    node16
    nodePackages.typescript-language-server
    nodePackages.pnpm
  ];
}
