{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "nixos-blur";
  version = "unstable-2022-07-08";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/nixos-blur-plymouth.git";
    rev = "ea75b51a1f04aa914647a2929eab6bbe595bcfc0";
    sha256 = "15iknbzqs460vn5bxilkrw31hszxj3kd428sw4097j5pdkwa2a85";
  };

  buildInputs = [ stdenv ];

  configurePhase = ''
    install_path=$out/share/plymouth/themes
    mkdir -p $install_path
  '';

  installPhase = ''
    cp -r nixos-blur $install_path
  '';

  meta = with stdenv.lib; { platfotms = platforms.linux; };
}
