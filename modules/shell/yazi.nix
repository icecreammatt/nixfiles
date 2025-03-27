{pkgs, ...}: let
  # Wrap yazi so images work
  yazi = pkgs.symlinkJoin {
    name = "yazi-wrapped";
    paths = [pkgs.yazi];
    nativeBuildInputs = [pkgs.makeBinaryWrapper];
    postBuild = ''
      wrapProgram "$out/bin/yazi" --set TERM_PROGRAM "WezTerm"
    '';
  };
in {
  home.file.".config/yazi/yazi.toml".source = ./yazi/yazi.toml;
  home.file.".config/yazi/keymap.toml".source = ./yazi/keymap.toml;
  home.file."nixfiles/.dotfiles/.config/yazi/yazi.toml".source = ./yazi/yazi.toml;
  home.file."nixfiles/.dotfiles/.config/yazi/keymap.toml".source = ./yazi/keymap.toml;

  home.packages = [yazi];
}
