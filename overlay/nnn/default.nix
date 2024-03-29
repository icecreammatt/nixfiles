{
  lib,
  stdenv,
  fetchFromGitHub,
  installShellFiles,
  makeWrapper,
  pkg-config,
  file,
  ncurses,
  readline,
  which,
  musl-fts,
  # options
  conf ? null,
  withColemak ? true,
  withIcons ? false,
  withNerdIcons ? true,
}:
# Mutually exclusive options
assert withIcons -> withNerdIcons == false;
assert withNerdIcons -> withIcons == false;
  stdenv.mkDerivation rec {
    pname = "nnn";
    version = "4.6";

    src = fetchFromGitHub {
      owner = "icecreammatt";
      repo = pname;
      rev = "colemak-neiu-nav";
      sha256 = "sha256-ScQ6Z6QjC4Lm/Poc2AHHA+KxD+fnOdWEUVkQzxYnx+4=";
    };

    configFile = lib.optionalString (conf != null) (builtins.toFile "nnn.h" conf);
    preBuild = lib.optionalString (conf != null) "cp ${configFile} src/nnn.h";

    nativeBuildInputs = [installShellFiles makeWrapper pkg-config];
    buildInputs = [readline ncurses] ++ lib.optional stdenv.hostPlatform.isMusl musl-fts;

    NIX_CFLAGS_COMPILE = lib.optionalString stdenv.hostPlatform.isMusl "-I${musl-fts}/include";
    NIX_LDFLAGS = lib.optionalString stdenv.hostPlatform.isMusl "-lfts";

    makeFlags =
      ["PREFIX=${placeholder "out"}"]
      ++ lib.optionals withColemak ["O_COLEMAK-DH=1"]
      ++ lib.optionals withIcons ["O_ICONS=1"]
      ++ lib.optionals withNerdIcons ["O_NERD=1"];

    binPath = lib.makeBinPath [file which];

    postInstall = ''
      installShellCompletion --bash --name nnn.bash misc/auto-completion/bash/nnn-completion.bash
      installShellCompletion --fish misc/auto-completion/fish/nnn.fish
      installShellCompletion --zsh misc/auto-completion/zsh/_nnn

      wrapProgram $out/bin/nnn --prefix PATH : "$binPath"
    '';

    meta = with lib; {
      description = "Small ncurses-based file browser forked from noice";
      homepage = "https://github.com/jarun/nnn";
      changelog = "https://github.com/jarun/nnn/blob/v${version}/CHANGELOG";
      license = licenses.bsd2;
      platforms = platforms.all;
      maintainers = with maintainers; [jfrankenau Br1ght0ne];
    };
  }
