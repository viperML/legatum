{
  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    builder = import ./builder.nix;
    genSystems = lib.genAttrs lib.systems.flakeExposed;
  in {
    packages = genSystems (system:
      with nixpkgs.legacyPackages.${system}; rec {
        stage1 = callPackage (builder {
          pname = "stage1";
          version = __substring 0 8 self.lastModifiedDate;
          deps = [
            "fedora-gpg-keys"
            "fedora-repos"
            "fedora-repos-modular"
          ];
        }) {};
        stage2 = callPackage (builder {
          pname = "stage2";
          version = __substring 0 8 self.lastModifiedDate;
          deps = [
            ./groups/core.nix
            "kernel-longterm"
            "kernel-longterm-devel"
            #
            "dracut"
            "lvm2"
            "cryptsetup"
            "zfs"
            "zfs-dracut"
          ];
        }) {};
        default = linkFarm "stages" (map (name: {
            inherit name;
            path = __getAttr name self.packages."x86_64-linux";
          })
          ["stage1" "stage2"]);
      });
    devShells = genSystems (system: {
      default = with nixpkgs.legacyPackages.${system};
        mkShell {
          inputsFrom = [self.packages.${system}.stage1];
        };
    });
  };
}
