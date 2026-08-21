{
  description = "715209's NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "github:hyprwm/Hyprland";

    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland";
    # };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      # hyprland,
      # split-monitor-workspaces,
      ...
    }@inputs:
    let
      user = "seven";

      hosts = [
        {
          hostname = "obelisk";
          system = "x86_64-linux";
        }
      ];

      makeSystem =
        { hostname, system }:
        let
          pkgsUnstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs = import nixpkgs {
            inherit system;
            #overlays = [ 
            #  (import ./nixos/overlays/rtl8126.nix)
            #  (self: super: {
            #    linux-firmware = super.linux-firmware.overrideAttrs (oldAttrs: {
            #      version = "20250410";
            #      src = pkgs.fetchzip {
            #        url = "https://cdn.kernel.org/pub/linux/kernel/firmware/linux-firmware-20250410.tar.xz ";
            #        hash = "sha256-aQdEl9+7zbNqWSII9hjRuPePvSfWVql5u5TIrGsa+Ao=";
            #      };
            #    });
            #  })
            #];
            config = {
              allowUnfree = true;
            };
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = pkgs;
          specialArgs = {
            inherit inputs hostname user pkgsUnstable;
          };
          modules = [
            ./hosts/${hostname}/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.${user} = import ./home-manager/home-manager.nix { inherit user inputs; };
            }
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs
        // {
          "${host.hostname}" = makeSystem {
            inherit (host) hostname system;
          };
        }
      ) { } hosts;
    };
}
