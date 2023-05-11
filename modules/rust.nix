{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bacon # Background rust code checker
    # cargo-info # Cargo subcommand to show crates info from crates.io
    clang-tools
    gcc
    grcov # Rust tool to collect and aggregate code coverage data for multiple source files
    rust-analyzer
    rust-script
    rustup
  ];
}
