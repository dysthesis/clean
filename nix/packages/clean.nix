{
  self,
  lib,
  pkgs,
  rustPlatform,
  symlinkJoin,
  cargo,
  rustc,
  luajit,
  pkg-config,
  makeWrapper,
  buildEnv,
  ...
}:
rustPlatform.buildRustPackage rec {
  name = "clean";
  version = "0.1.0";

  nativeBuildInputs = [
    cargo
    rustc
    pkg-config
  ];

  RUSTFLAGS = [
    "-Zlocation-detail=none"
    "-Zfmt-debug=none"
  ];

  src = ../../.;
  cargoLock.lockFile = "${src}/Cargo.lock";
}
