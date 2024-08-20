{
  description = "A simple flake to build nix packages";

  inputs = {
    /** pulsar: https://github.com/NixOS/nixpkgs/pull/335896 */
    nixpkgs.url = "github:NixOS/nixpkgs/a7201146e68e726ea7d0005dbad81824ef0287e0";
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
