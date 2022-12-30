Reproducible example of nix-rebar3 build failure when using nixpkgs/nixos-22.11

When moving from "nixpkgs/nixos-22.05" to "nixpkgs/nixos-22.11" my build started failing during `installPhase` with `consumeEntire(): ERROR: Input null bytes, won't process`, due to `$out/rel/*/erts-*/bin/erl` now being a binary file (crashing `substituteInPlace` here https://github.com/axelf4/nix-rebar3/blob/master/default.nix#L147).

```
nix build .#works
nix build .#fails
```
