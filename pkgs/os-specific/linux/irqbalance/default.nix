{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, glib, ncurses, libcap_ng }:

stdenv.mkDerivation rec {
  name = "irqbalance-${version}";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "irqbalance";
    repo = "irqbalance";
    rev = "v${version}";
    sha256 = "1wdwch4nb479xhinin4yqvcjah6h09i4nh8fhnsfbn1mzl0hiv09";
  };

  nativeBuildInputs = [ autoreconfHook pkgconfig ];
  buildInputs = [ glib ncurses libcap_ng ];

  LDFLAGS = "-lncurses";

  meta = {
    homepage = https://github.com/Irqbalance/irqbalance;
    description = "A daemon to help balance the cpu load generated by interrupts across all of a systems cpus";
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.linux;
  };
}
