{
  description = "NixOS Hyprland - Exatio's flake";

  inputs = {

    #nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    #home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    catppuccin.url = "github:catppuccin/nix";
    
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, catppuccin, lanzaboote, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    #unstable-pkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    isDesktop = builtins.hasAttr "desktop" self.nixosConfigurations;
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
                catppuccin.homeModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = { inherit inputs pkgs isDesktop; };
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
                catppuccin.homeModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = { inherit inputs pkgs isDesktop; };
          }
        ];
        specialArgs = { inherit inputs; };
      };

    };

  };
}
