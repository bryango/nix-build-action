{
  description = "A simple flake to build nix packages";

  inputs = {
    /** wechat-uos: https://github.com/NixOS/nixpkgs/pull/293730 */
    nixpkgs.url = "github:NixOS/nixpkgs/8e25ca31b37d687e5747d86278c2e530c6d3da49";
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
        default = pkgs.wechat-uos;
      });
    };
}
