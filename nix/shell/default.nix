{
  pkgs,
  self,
  ...
}:
pkgs.mkShell {
  name = "clean";
  
  packages = with pkgs; [
    nixd
    alejandra
    statix
    deadnix
    cargo
    rustToolchains.nightly
    bacon
  ];
}
