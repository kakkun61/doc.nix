treefmt.toml:
	nix build .#treefmt-config --out-link $@

lib.md: lib.nix flake.nix flake.lock
	nix build .#lib-doc --out-link result-$@
	cp result-$@ $@
