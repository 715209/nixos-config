{
  description = "715209's NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; 

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ghostty, ... }:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      vm-aarch64 = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./users/seven/nixos.nix
          machines/vm-aarch64.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.seven = import ./users/seven/home-manager.nix;
          }
	  {
            environment.systemPackages = [
              ghostty.packages.aarch64-linux.default
	    ];
	  }
        ];
      };
    };
  };
}
