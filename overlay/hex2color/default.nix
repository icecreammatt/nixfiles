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
    rev = "main";
    sha256 = "sha256-6zz2hmtxIQapue/wPexCwQ8dB7vdDD6xacn/OMrJERQ=";
  };

  cargoHash = "sha256-XRuAOny7A9RhIm7VzlK81MWF9lSmiw8AWcTIPFursVo=";

  meta = with lib; {
    description = "CLI utility that takes a hex or RGB value and outputs a color swatch";
    homepage = "https://github.com/icecreammatt/hex2color";
    license = licenses.mit;
  };
}
