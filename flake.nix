{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    nix-darwin,
    nixos-hardware,
    home-manager,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {pkgs, ...}: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
        };
      };

      flake = {
        nixosConfigurations = {
          laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [
              inputs.stylix.nixosModules.stylix
              ./hosts/laptop/default.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.backupFileExtension = "backup2";
                home-manager.users.mitch = import ./home/mitch.nix;
                home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
                home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
              }
            ];
          };

          laptop-nvidia = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [
              inputs.stylix.nixosModules.stylix
              ./hosts/laptop-nvidia/default.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.backupFileExtension = "backup2";
                home-manager.users.mitch = import ./home/mitch.nix;
                home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
                home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
              }
            ];
          };

          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [
              inputs.stylix.nixosModules.stylix
              ./hosts/desktop/default.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.backupFileExtension = "backup2";
                home-manager.users.mitch = import ./home/mitch.nix;
                home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
                home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
              }
            ];
          };

          rpi4 = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = {inherit inputs;};
            modules = [
              inputs.stylix.nixosModules.stylix
              nixos-hardware.nixosModules.raspberry-pi-4
              ./hosts/rpi4/default.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.backupFileExtension = "backup2";
                home-manager.users.mitch = import ./home/mitch.nix;
                home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
                home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
              }
            ];
          };
        };

        darwinConfigurations = {
          macos = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = {inherit inputs;};
            modules = [
              ./hosts/macos/default.nix
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.backupFileExtension = "backup";
                home-manager.users.mitch = import ./home/mitch.nix;
                home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
                home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
              }
            ];
          };
        };
      };
    };
}
