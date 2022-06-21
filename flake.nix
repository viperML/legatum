{
  outputs = {
    self,
    nixpkgs,
  }: let
    builder = import ./builder.nix;
  in {
    packages."x86_64-linux" = with nixpkgs.legacyPackages."x86_64-linux"; rec {
      stage1 = callPackage (builder {
        pname = "stage1";
        version = __substring 0 8 self.lastModifiedDate;
      }) {};
      stage2 = callPackage (builder {
        pname = "stage2";
        version = __substring 0 8 self.lastModifiedDate;
        deps = [
          "kernel-default"
          "kernel-firmware"
          "zfs"
          "cryptsetup"
          "lvm2"
          "dracut"
        ];
      }) {};
      default = linkFarm "stages" (map (name: {
          inherit name;
          path = __getAttr name self.packages."x86_64-linux";
        })
        ["stage1" "stage2"]);
    };
    devShells."x86_64-linux".default = with nixpkgs.legacyPackages."x86_64-linux";
      mkShell {
        inputsFrom = [self.packages."x86_64-linux".stage1];
      };
  };
}
