{
  description = "A simple flake to build nix packages";

  inputs = {
    /** pulsar: https://github.com/NixOS/nixpkgs/pull/358575 */
    nixpkgs.url = "github:NixOS/nixpkgs/a73a3fd4bca8d4cdb3af8616cd4dbad553367175";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        # "x86_64-darwin"
        "aarch64-linux"
        # "aarch64-darwin"
      ];

      inherit (nixpkgs) lib;
      forAllSystems = f: lib.genAttrs systems (system: f {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowInsecurePredicate = x: true;
            allowBroken = true;
            allowUnfree = true;
          };
        };
        final = self.packages.${system};
      });
    in
    {
      legacyPackages = forAllSystems ({ pkgs, ... }: pkgs);
      packages = forAllSystems ({ pkgs, ... }: {
        /** the default package to build */
        default = pkgs.pulsar;
      });
    };
}
