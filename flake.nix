{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
    
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    

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

  
  in
  {
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
      modules = [
        ./configuration.nix
      ];
    };
    
    homeConfigurations = {
      mitch = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
      
      modules = [
        ./home.nix
        ];
      extraSpecialArgs = { inherit inputs; };
    };

  };
};
}
