{ pkgs }:

pkgs.writeShellScriptBin "hello" ''
  echo "Hello World" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
''