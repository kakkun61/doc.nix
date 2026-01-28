{
  description = "Runtime documentation for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cspell-nix = {
      url = "github:kakkun61/cspell-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      treefmt-nix,
      cspell-nix,
      ...
    }:
    let
      lib = import ./lib.nix { inherit (nixpkgs) lib; };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
        cspell-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          pkgs,
          config,
          ...
        }:
        {
          packages = {
            lib-doc = pkgs.writeText "lib.md" ''
              # doc.nix library documentation

              This document is generated and do not edit manually.

              ${lib.makeCommonMark { } (lib.makeDocSet { } lib)}
            '';
            treefmt-config = config.treefmt.build.configFile;
          };
          treefmt.programs.nixfmt.enable = true;
          cspell.configFile = ./cspell.yaml;
        };
      flake = {
        inherit lib;
      };
    };
}
