{pkgs, ...}: let
  preview.sh = pkgs.writeShellScriptBin "preview.sh" (builtins.readFile ./scripts/preview.sh);
in {
  home.packages = [
    preview.sh
  ];
}
