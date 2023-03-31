{ lib , stdenv , fetchFromGitHub , ncurses6 }:

stdenv.mkDerivation rec {
  pname = "worm";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "icecreammatt";
    repo = "ssu-cs315-worm";
    rev = "master";
    sha256 = "sha256-GVt4npy3j5VJ+0VhfW/GMKE8jyv6taUiW39xj0rTzmU=";
  };

  buildInputs = [ ncurses6 ];

  buildPhase = "cd src/ && COMPILER='clang++' make";

  installPhase = ''
    mkdir -p $out/bin;
    install -t $out/bin worm
  '';

  meta = with lib; {
    description = "Small ncurses-based file browser forked from noice";
    homepage = "https://github.com/icecreammatt/ssu-cs315-worm";
    platforms = platforms.all;
  };
}
