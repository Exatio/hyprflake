{
  description = "NixOS Hyprland - Exatio's flake";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-24.05";
    #nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    #home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    catppuccin.url = "github:catppuccin/nix";
    
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    # temporary, as the official nixpkgs ryujinx package is down 
    ryujinx.url = "github:Naxdy/Ryujinx";

  };

  outputs = { self, nixpkgs, home-manager, catppuccin, lanzaboote, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    #unstable-pkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
  in {

    nixosConfigurations = {

      laptop = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          catppuccin.nixosModules.catppuccin
          lanzaboote.nixosModules.lanzaboote
          ./hosts/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.exatio = {
              imports = [
                ./home/exatio.nix
                ./home/programs/hyprland/vars-laptop.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = { inherit inputs pkgs; };
          }
        ];
        specialArgs = { inherit inputs; };
      };

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          catppuccin.nixosModules.catppuccin
          lanzaboote.nixosModules.lanzaboote
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.exatio = {
              imports = [
                ./home/exatio.nix
                ./home/programs/hyprland/vars-desktop.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = { inherit inputs pkgs; };
          }
        ];
        specialArgs = { inherit inputs; };
      };

    };

  };
}
