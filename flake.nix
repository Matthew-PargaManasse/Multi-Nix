{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

        #    plugin-onedark.url = "github:navarasu/onedark.nvim";
        #    plugin-onedark.flake = false;

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:

  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    host = "nixos";
    profile = "nvidia-laptop";
    username = "lithobreaker";


  in
  {

    nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs system; };
            modules = [
                ./hosts/nixos/configuration.nix
            ];
        };
        amd = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [./profiles/amd];
      };
      nvidia = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [./profiles/nvidia];
      };
      nvidia-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [./profiles/nvidia-laptop];
      };
      intel = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [./profiles/intel];
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [./profiles/vm];
      };
    };

      mitch = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

      modules = [
        ./home/mitch/home.nix
        {
          wayland.windowManager.hyprland = {
            enable = true;
            # set the flake package
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };
        }
        ];
      extraSpecialArgs = { inherit inputs; };
    };


      lithobreaker = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

      modules = [
        ./home/lithobreaker/default.nix
        ];
      extraSpecialArgs = { inherit inputs; };
    };


  };
}
