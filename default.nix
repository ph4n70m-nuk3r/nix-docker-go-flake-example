{ pkgs ? (
    let
      inherit (builtins) fetchTree fromJSON readFile;
      inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs gomod2nix;
    in
    import (fetchTree nixpkgs.locked) {
      overlays = [
        (import "${fetchTree gomod2nix.locked}/overlay.nix")
      ];
    }
  )
, buildGoApplication ? pkgs.buildGoApplication
}:

(buildGoApplication {
  pname = "nix-docker-go-flake-example";
  version = "0.1";
  pwd = ./.;
  src = ./.;
  modules = ./gomod2nix.toml;

  nativeBuildInputs = [ pkgs.musl pkgs.gcc ];
  ldflags = [
    "-extldflags -static"
    "-s"  # strip debug info
    "-w"
  ];
}).overrideAttrs (old: {
  # Override CGO_ENABLED
  CGO_ENABLED = "0";
})
