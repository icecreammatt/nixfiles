{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  name = "serpl";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "icecreammatt";
    repo = "serpl";
    rev = "nix-flakes";
    sha256 = "sha256-zkxTD3quE2fcDyWGBLktln7MMkBRJQ66kvqf26FOj2A=";
  };

  cargoHash = "sha256-ZjpFwbuH1ywUDrYrjmX+alsEDBYjuQaMO2v9+mUQbZ0=";

  meta = with lib; {
    description = "A simple terminal UI for search and replace, ala VS Code.";
    homepage = "https://github.com/icecreammatt/serpl";
  };
}
