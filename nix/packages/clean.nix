{
  rustPlatform,
  pkg-config,
  rust-bin,
  ...
}: let
  nightlyToolchain = rust-bin.selectLatestNightlyWith (toolchain: toolchain.minimal);
in
  rustPlatform.buildRustPackage rec {
    name = "clean";
    version = "0.1.0";

    nativeBuildInputs = [
      pkg-config
      nightlyToolchain
    ];

    RUSTFLAGS = [
      "-Zlocation-detail=none"
      "-Zfmt-debug=none"
    ];

    src = ../../.;
    cargoLock.lockFile = "${src}/Cargo.lock";
  }
