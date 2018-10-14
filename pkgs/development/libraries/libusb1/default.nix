{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, systemd ? null, libobjc, IOKit }:

stdenv.mkDerivation rec {
  name = "libusb-${version}";
  version = "1.0.22";

  src = fetchFromGitHub {
    owner = "libusb";
    repo = "libusb";
    rev = "v${version}";
    sha256 = "1cff09csp8z4jd3165xa0i2zii5dvcin3j3v56vqjzni0wagaw0l";
  };

  outputs = [ "out" "dev" ]; # get rid of propagating systemd closure

  nativeBuildInputs = [ pkgconfig autoreconfHook ];
  propagatedBuildInputs =
    stdenv.lib.optional stdenv.isLinux systemd ++
    stdenv.lib.optionals stdenv.isDarwin [ libobjc IOKit ];

  NIX_LDFLAGS = stdenv.lib.optionalString stdenv.isLinux "-lgcc_s";

  preFixup = stdenv.lib.optionalString stdenv.isLinux ''
    sed 's,-ludev,-L${systemd.lib}/lib -ludev,' -i $out/lib/libusb-1.0.la
  '';

  meta = {
    homepage = http://www.libusb.info;
    description = "User-space USB library";
    platforms = stdenv.lib.platforms.all;
    maintainers = [ ];
  };
}
