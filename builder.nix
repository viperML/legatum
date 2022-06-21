{
  pname,
  version,
  deps ? [],
}: {
  stdenv,
  fpm,
  fakeroot,
  rpm,
  lib,
}:
stdenv.mkDerivation rec {
  inherit pname version;
  src = builtins.path {
    path = ./. + "/${pname}";
    name = "${pname}-source";
  };
  nativeBuildInputs = [
    fpm
    fakeroot
    rpm
  ];
  buildPhase = ''
    set -x
    trap "set +x" ERR
    fakeroot fpm ${lib.concatMapStringsSep " " (d: "--depends ${d}") deps} \
      --input-type dir \
      --output-type rpm \
      --version ${version} \
      --name ${pname} \
      --chdir $src \
      --exclude "*.spec" \
      .
    set +x
  '';
  installPhase = ''
    mkdir -p $out
    install -Dm444 *.rpm $out
  '';
}
