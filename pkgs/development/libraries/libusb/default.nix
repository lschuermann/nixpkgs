{stdenv, fetchurl, pkgconfig, libusb1}:

stdenv.mkDerivation rec {
  name = "libusb-compat-${version}";
  version = "0.1.7";

  outputs = [ "out" "dev" ]; # get rid of propagating systemd closure
  outputBin = "dev";

  nativeBuildInputs = [ pkgconfig ];
  propagatedBuildInputs = [ libusb1 ];

  src = fetchurl {
    url = "https://github.com/libusb/libusb-compat-0.1/releases/download/v${version}/${name}.tar.gz";
    sha256 = "1y2wjba4w9r53sfaacj6awyqhmi31n53j4wwx8g8qj82m8wcwy86";
  };

  patches = stdenv.lib.optional stdenv.hostPlatform.isMusl ./fix-headers.patch;

  meta = {
    platforms = stdenv.lib.platforms.unix;
  };
}
