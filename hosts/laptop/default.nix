{ inputs, pkgs, ... }:
{
  imports = [
    ../common.nix # whatever the host, theses settings will not change

    ../users/mainuser.nix
    # inputs.sops-nix.nixosModules.sops

    # Hardware dependent
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-pc
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd

  ];

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };
/*
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
*/
  # For Thunar
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };
  services.tumbler.enable = true;


  # Allow KDE Connect
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # Zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Time
  time = {
    timeZone = "Europe/Paris";
  };

  # Kernel Packages
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Network hostname
  networking.hostName = "nixos-laptop";

  # Bluetooth
  hardware.bluetooth.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
