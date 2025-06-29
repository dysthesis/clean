{
  rustToolchains,
  rustPlatform,
  pkg-config,
  cacert,
  makeWrapper,
  ...
}: let
  inherit (rustToolchains) nightly;
in
  rustPlatform.buildRustPackage rec {
    pname = "clean";
    version = "0.1.0";
    src = ../../.;
    cargoLock.lockFile = "${src}/Cargo.lock";

    nativeBuildInputs = [pkg-config nightly makeWrapper];
    buildInputs = [cacert];

    postInstall = ''
      wrapProgram $out/bin/clean \
        --set SSL_CERT_FILE ${cacert}/etc/ssl/certs/ca-bundle.crt
    '';
  }
