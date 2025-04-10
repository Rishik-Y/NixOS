{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
    nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        # Make sure no unsupported options are used here
      ];
    };
  });
}
