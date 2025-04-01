{
  description = "A simple flake to build nix packages";

  inputs = {
    /** pulsar: 127.1 */
    nixpkgs.url = "github:NixOS/nixpkgs?ref=pull/395034/merge";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
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
