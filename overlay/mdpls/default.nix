{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "mdpls";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "icecreammatt";
    repo = "mdpls";
    rev = "nix-flakes";
    sha256 = "sha256-1/aFim6rMnsIcEy054RMdnXGB26sYZ9GsUoSIo1g6xU=";
  };

  cargoHash = "sha256-s6aHs0kCPYi/IsSr7GoaemMMQerm5LnUovH6D7z25Ms=";

  meta = with lib; {
    description = "lsp for markdown";
    homepage = "https://github.com/icecreammatt/mdpls";
  };
}
