{stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, libusb1}:

stdenv.mkDerivation rec {
  name = "libusb-compat-${version}";
  version = "0.1.7";

  outputs = [ "out" "dev" ]; # get rid of propagating systemd closure
  outputBin = "dev";

  nativeBuildInputs = [ pkgconfig autoreconfHook ];
  propagatedBuildInputs = [ libusb1 ];

  src = fetchFromGitHub {
    owner = "libusb";
    repo = "libusb-compat-0.1";
    rev = "v${version}";
    sha256 = "1nybccgjs14b3phhaycq2jx1gym4nf6sghvnv9qdfmlqxacx0jz5";
  };

  patches = stdenv.lib.optional stdenv.hostPlatform.isMusl ./fix-headers.patch;

  meta = {
    platforms = stdenv.lib.platforms.unix;
  };
}
