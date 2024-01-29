# nodejs version 18.15.0
{
  description = "Node 18 App";

  inputs = {
    # Pointing to the current stable release of nixpkgs. You can
    # customize this to point to an older version or unstable if you
    # like everything shining.
    #
    # E.g.
    #
    # nixpkgs.url = "github:NixOS/nixpkgs/unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
    inputs.utils.lib.eachSystem [
      # Add the system/architecture you would like to support here. Note that not
      # all packages in the official nixpkgs support all platforms.
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ] (system: let
      # Download custom pinned versoin of node from nixpkgs
      pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/708dcbce926fdfb40a08ff625148fe11b6fe601d.tar.gz";
        sha256 = "1gm4garc5qk11hkxbiqf85wxnr9c67jw4bm69afxqcnchh9b4fai";
      }) {inherit system;};

      # assign custom node build to node18 variable for later reference
      node18 = pkgs.nodejs;
    in {
      # This block here is used when running `nix develop`
      devShells.default =
        pkgs.mkShell rec {
          # Update the name to something that suites your project.
          name = "node 18";

          # include the new custom release override
          packages = with pkgs; [node18];

          # Release should say 18.15.0
          buildPhase = "
        node --version
      ";

          # Setting up the environment variables you need during development.

          # Todo figure out why I can't use clang on Asahi but can on Darwin
          # Use "clang++" for most systems but OSX Asahi requires g++ for some reason or a runtime error occurs
          shellHook = let
            # This is for an icon that is used below for the command line input below
            icon = "f121";
          in ''
            export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
          '';
        };

      # This is used when running `nix build`
      packages.default =
        pkgs.stdenv.mkDerivation rec {
          name = "node18";
          version = "0.0.1";

          src = self;

          buildInputs = [pkgs.node18];

          buildPhase = "
        node --version
      ";
        };
    });
}
