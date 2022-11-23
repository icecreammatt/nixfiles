{ pkgs, ... }:
{
    programs.navi = {
        enable = true;
    };

    home.file = {
      ".config/navi/directories.txt".text = ''
          source ~/Source
          nixfiles ~/nixfiles
          navi-urls ~/.config/navi/
          navi-directories ~/.config/navi/
          navi-cheats ~/Library/Application\ Support/navi/cheats/
      '';

      ".config/navi/urls.txt".text = ''
          nixpkg,search https://search.nixos.org/packages
      '';

    };
}
