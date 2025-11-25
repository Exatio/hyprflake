{
  description = "NixOS Hyprland - Exatio's flake";

  inputs = {

    /* nixpkgs */
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.3";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    /* hypr stuff */
    hyprland.url = "github:hyprwm/hyprland";

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    
    hypr-darkwindow.url = "github:micha4w/Hypr-DarkWindow";
    hypr-darkwindow.inputs.hyprland.follows = "hyprland";

    /* misc */
    hardware.url = "github:nixos/nixos-hardware";

  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs:
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
          lanzaboote.nixosModules.lanzaboote
          ./hosts/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.exatio = {
              imports = [
                ./home/exatio.nix
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
          lanzaboote.nixosModules.lanzaboote
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.exatio = {
              imports = [
                ./home/exatio.nix
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
