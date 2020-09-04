{ buildPythonPackage, python, fetchurl, stdenv,
  cmake, ninja, qt5, shiboken2 }:

stdenv.mkDerivation rec {
  pname = "pyside2";
  version = "5.15.0";

  src = fetchurl {
    url = "https://download.qt.io/official_releases/QtForPython/pyside2/PySide2-${version}-src/pyside-setup-opensource-src-${version}.tar.xz";
    sha256 = "0s3bgddcsf6w297nyxv08xpc2nnr3sli980p24nf4xivvr9yxkgi";
  };

  patches = [
    ./dont_ignore_optional_modules.patch
  ];

  postPatch = ''
    cd sources/pyside2
  '';

  cmakeFlags = [
    "-DBUILD_TESTS=OFF"
    "-DPYTHON_EXECUTABLE=${python.interpreter}"
  ];

  nativeBuildInputs = [ cmake ninja qt5.qmake python ];
  buildInputs = with qt5; [
    qtbase qtxmlpatterns qtmultimedia qttools qtx11extras qtlocation qtscript
    qtwebsockets qtwebengine qtwebchannel qtcharts qtsensors qtsvg
  ];
  propagatedBuildInputs = [ shiboken2 ];

  meta = with stdenv.lib; {
    description = "LGPL-licensed Python bindings for Qt";
    license = licenses.lgpl21;
    homepage = "https://wiki.qt.io/Qt_for_Python";
    maintainers = with maintainers; [ gebner ];
  };
}
