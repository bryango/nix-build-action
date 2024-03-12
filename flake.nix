{
  description = "A simple flake to build nix packages";

  inputs = {
    /** tectonic-inherit-argv0: https://github.com/NixOS/nixpkgs/pull/295314 */
    nixpkgs.url = "github:NixOS/nixpkgs/a6504022e79c77d9ba5a77bc905b88ebb2f4530f";
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
          config.allowInsecurePredicate = x: true;
        };
        final = self.packages.${system};
      });
    in
    {
      legacyPackages = forAllSystems ({ pkgs, ... }: pkgs);
      packages = forAllSystems ({ pkgs, ... }: {
        /** the default package to build */
        default = pkgs.tectonic;
      });
    };
}
