{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/80a35c4b-c9cf-409f-86c3-687cce84dfe5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/023B-9C3D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/Windows" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs3";
    options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" ];
  };

  fileSystems."/mnt/SDD1TB" = {
    device = "/dev/sda1";
    fsType = "ntfs3";
    options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" ];
  };


  fileSystems."/mnt/HDD4TB" = {
    device = "/dev/sdb1";
    fsType = "ntfs3";
    options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp10s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
