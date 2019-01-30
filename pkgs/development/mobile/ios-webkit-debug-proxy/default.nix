{ stdenv, fetchzip, autoconf, automake, libusb, libplist, pkgconfig, libtool, libimobiledevice }:

stdenv.mkDerivation rec {
  name = "ios-webkit-debug-proxy-${version}";
  version = "v1.8.3";

  src = fetchzip {
    url = "https://github.com/google/ios-webkit-debug-proxy/archive/${version}.tar.gz";
    sha256 = "1xp854pyj5rwdim093xm182cb5a4ksaf50yqax1g90mx0kp2sxn2";
  };

  buildInputs = [ autoconf automake libusb libplist pkgconfig libtool libimobiledevice ];

  configurePhase = "./autogen.sh --prefix=$out";


  meta = with stdenv.lib; {
    description = "Debug MobileSafari and UIWebViews on real & simulated iOS devices.";
    longDescription = ''
      The ios_webkit_debug_proxy (aka iwdp) proxies requests from usbmuxd daemon over a websocket connection, allowing developers to send commands to MobileSafari and UIWebViews on real and simulated iOS devices.
    '';
    homepage = https://github.com/google/ios-webkit-debug-proxy;
    # license = licenses.gpl3; # google BSD license
    # maintainers = with maintainers; [ yegortimoshenko ];
    platforms = platforms.linux;
  };
}
