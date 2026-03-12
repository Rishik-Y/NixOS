{
  description = "Home Manager configuration of kihsir";

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add nixGL
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 1. Add Zen Browser input
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixgl, nix-openclaw,
  zen-browser,
  ... }:
    let
      system = "x86_64-linux";
  pkgs = import nixpkgs {        # ← inside let, before 'in'
    inherit system;
    overlays = [ nix-openclaw.overlays.default ];
  };
  in {
      homeConfigurations."kihsir" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Pass nixgl to home.nix so you can use it there
        extraSpecialArgs = {
          inherit nixgl
	  nix-openclaw
	  zen-browser
	  ;
        };
      };
    };
}
