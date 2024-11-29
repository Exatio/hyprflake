{ inputs, outputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "14m";
      # Keep the last 5 generations
      options = "--delete-older-than +5";
    };
  };

  # Bootloader
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 5;

      systemd-boot = {
        enable = pkgs.lib.mkForce false;
        configurationLimit = 3; # shows only last 3 generations on boot
        memtest86.enable = true;
      };
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

   # For NTFS Support
  boot.supportedFilesystems = [ "ntfs" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Internationalisation
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # Sound
  sound.enable = true;
  # hardware.pulseaudio.enable = false;
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      wireplumber = {
        enable = true;
        package = pkgs.wireplumber;
      };
    };
  };

  # Fonts
  fonts.fontDir.enable = true;

  # Network
  networking.networkmanager.enable = true;
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  # File manager
  environment.systemPackages = with pkgs.kdePackages; [
    dolphin
    qtwayland
    qtsvg
  ];

  security.polkit.enable = true;

}
