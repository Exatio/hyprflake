{ pkgs, ... }:
{
  imports = [
    ../plasma.nix
    ../hyprland.nix
  ];

  # User settings
  users.users.exatio = {
    isNormalUser = true;
    description = "Exatio";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "aa";
  };

}
