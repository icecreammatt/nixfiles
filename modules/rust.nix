{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bacon # Background rust code checker
    # cargo-info # Cargo subcommand to show crates info from crates.io
    clang-tools
    gcc
    rust-analyzer
    rust-script
    rustup
  ];
}
