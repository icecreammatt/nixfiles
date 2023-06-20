# nodejs version 18.15.0

# Use this command to get a valid hash
#nix-prefetch-url https://github.com/NixOS/nixpkgs/archive/708dcbce926fdfb40a08ff625148fe11b6fe601d.tar.gz
#path is '/nix/store/2hlvr0mpwlfnlfa11z058dlyjdb1nxak-708dcbce926fdfb40a08ff625148fe11b6fe601d.tar.gz'
#1xqrylqqgapiwn91cvgsml9c42ywa1hp3hvh5x0apb6jpjjkqk7z
# after trying to install it wilL fail and say it got Y hash instead. Replace the sha256 with Y hash


{  pkgs, ... }:

let
    system = "x86_64-darwin"; # Todo see how to pass this through from parent
    # version = "16.13.1"; <-- this is for refence for the build sha below
    pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/708dcbce926fdfb40a08ff625148fe11b6fe601d.tar.gz";
      sha256 = "1gm4garc5qk11hkxbiqf85wxnr9c67jw4bm69afxqcnchh9b4fai";
    }) { inherit system; };

    node18 = pkgs.nodejs;
in
{
  home.packages = with pkgs; [
    node18
    nodePackages.typescript-language-server
    nodePackages.pnpm
  ];
}
