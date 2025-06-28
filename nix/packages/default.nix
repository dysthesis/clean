{
  self,
  pkgs,
  lib,
  inputs,
  ...
}: rec {
  default = clean;
  clean = pkgs.callPackage ./clean.nix {inherit pkgs inputs lib self;};
}
