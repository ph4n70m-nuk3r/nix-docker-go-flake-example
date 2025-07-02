{
  description = "Nix flake example for a containerised go application with external dependencies.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix.url = "github:nix-community/gomod2nix";
    gomod2nix.inputs.nixpkgs.follows = "nixpkgs";
    gomod2nix.inputs.flake-utils.follows = "flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, gomod2nix } @ inputs:
    (flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          callPackage = pkgs.callPackage;
          go-app-derivation = callPackage ./. {
            inherit (gomod2nix.legacyPackages.${system}) buildGoApplication;
          };
        in
        {
          packages.default = go-app-derivation;
          packages.docker = pkgs.dockerTools.buildLayeredImage {
            name = "nix-docker-go-flake-example";
            tag = "latest";
            contents = with pkgs; [ cacert ];
            config.Cmd = "${go-app-derivation}/bin/nix-docker-go-flake-example";
          };
          devShells.default = callPackage ./shell.nix {
            inherit (gomod2nix.legacyPackages.${system}) mkGoEnv gomod2nix;
          };
        })
    ) // { nixosModules.default = import ./services.nix inputs; };
}
