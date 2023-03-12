{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    rust-analyzer
    rust-script
    rustup
    gcc
    clang-tools
  ];
}