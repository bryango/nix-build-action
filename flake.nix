{
  description = "A simple flake to build nix packages";

  inputs = {
    /** pulsar-bump-fix: https://github.com/NixOS/nixpkgs/pull/292611 */
    nixpkgs.url = "github:NixOS/nixpkgs/011b1ee22c4f5ddd41f054ec3e43b7b0f4f58fe4";
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
      packages = forAllSystems ({ pkgs, ... }: pkgs // {
        default = pkgs.pulsar;
      });
    };
}
