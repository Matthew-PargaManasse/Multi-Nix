{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nix-darwin, nixos-hardware, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          inputs.stylix.nixosModules.stylix
          ./hosts/laptop/default.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.mitch = import ./home/mitch.nix;
            home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
            home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
          }
        ];
      };
      
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          inputs.stylix.nixosModules.stylix
          ./hosts/desktop/default.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.mitch = import ./home/mitch.nix;
            home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
            home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
          }
        ];
      };
      
      rpi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.stylix.nixosModules.stylix
          nixos-hardware.nixosModules.raspberry-pi-4
          ./hosts/rpi4/default.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
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
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macos/default.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.mitch = import ./home/mitch.nix;
            home-manager.users.mitch-daily = import ./home/mitch-daily.nix;
            home-manager.users.mitch-embedded = import ./home/mitch-embedded.nix;
          }
        ];
      };
    };
  };
}
