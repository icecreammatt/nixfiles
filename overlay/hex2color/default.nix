{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  name = "hex2color";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "icecreammatt";
    repo = "hex2color";
    rev = "a6686bca45835ab9c089bb61996e38ba24fd4c3e";
    sha256 = "sha256-rwGxvxVUVcVklAAm02UqWkUvc/ZF84jX7Rf/hUFfqzU=";
  };

  cargoHash = "sha256-XRuAOny7A9RhIm7VzlK81MWF9lSmiw8AWcTIPFursVo=";

  meta = with lib; {
    description = "CLI utility that takes a hex or RGB value and outputs a color swatch";
    homepage = "https://github.com/icecreammatt/hex2color";
    license = licenses.mit;
  };
}
