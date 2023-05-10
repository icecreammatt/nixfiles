{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bacon
    clang-tools
    gcc
    rust-analyzer
    rust-script
    rustup
  ];
}
