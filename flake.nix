{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        devShells.default = with pkgs;
          mkShell.override {stdenv = stdenvNoCC;} {
            packages = [
              fpm
              shellcheck
            ];
          };
      };
    };
}
