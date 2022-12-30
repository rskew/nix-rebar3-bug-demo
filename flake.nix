{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    old-nixpkgs.url = "nixpkgs/nixos-22.05";
    nix-rebar3.url = "github:axelf4/nix-rebar3";
    nix-rebar3.inputs.nixpkgs.follows = "nixpkgs";
    nix-rebar3-oldnixpkgs.url = "github:axelf4/nix-rebar3";
    nix-rebar3-oldnixpkgs.inputs.nixpkgs.follows = "old-nixpkgs";
  };

  outputs = { self, nixpkgs, old-nixpkgs, nix-rebar3, nix-rebar3-oldnixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
        old-pkgs = old-nixpkgs.legacyPackages.x86_64-linux;
    in rec {
      packages.x86_64-linux.fails =
        (pkgs.callPackage nix-rebar3 {}).buildRebar3 {
          root = ./.;
          pname = "hello";
          version = "0.1.0";
          releaseType = "release";
        };
      packages.x86_64-linux.works =
        (old-pkgs.callPackage nix-rebar3-oldnixpkgs {}).buildRebar3 {
          root = ./.;
          pname = "hello";
          version = "0.1.0";
          releaseType = "release";
        };
    };
}
