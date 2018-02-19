{ stdenv, rustPlatform, fetchFromGitHub, pkgconfig, sqlite, mysql, postgresql}:

rustPlatform.buildRustPackage rec {
  name = "diesel-cli-${version}";
  version = "00";

  #src = fetchFromGitHub {
  #  owner = "diesel-rs";
  #  repo = "diesel";
  #  rev = "7201e3f186a8f4290b3cfef84452b63c370a29df";
  #  sha256 = "0qy88q70w0qs86i5bv06ns12z475rl7mqx365f0rl4lq3rm8gj24";
  #};
  #cargoSha256 = "580c037940f7e4155327f5b701e09eb27277ddefb1d0ae96fe1ffccd7a5e02a9";
  src = fetchFromGitHub {
    owner = "lschuermann";
    repo = "diesel";
    rev = "1cc9a37780d7ffef83ca70ee59f7cf279d97a5ce";
    sha256 = "1i4da49yllgypd53172cdz9ly2d1jig4pg8nmqw2ry0wvhk8fq1q";
  };
  cargoSha256 = "0gd4vdqcki5laqakzh367cfzcvg2mjfvhscvmg6k4lgpz6sgx02y";


  nativeBuildInputs = [ sqlite mysql postgresql ];

  #buildInputs = [ sqlite ];
  buildInputs = [ ];

  meta = with stdenv.lib; {
    description = "Diesel ORM command line utility";
    homepage = https://github.com/diesel-rs/diesel;
    license = licenses.mit;
    maintainers = [ maintainers.lschuermann ];
    platforms = platforms.linux;
  };
}
