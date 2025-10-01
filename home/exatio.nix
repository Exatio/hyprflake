{ inputs, lib, pkgs, ... }:
{

  imports = [
    ./programs/git
    
    ./programs/firefox

    ./programs/code
    ./programs/games

    ./fonts

    ./desktops/hyprland.nix
  ];

  home = {
    username = "exatio";
    homeDirectory = "/home/exatio";
    packages = with pkgs; [
      # Web
      # firefox
      ungoogled-chromium

      # Discord
      /*
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      */
      vesktop

      # Other
      keepassxc # password manager
      cool-retro-term
      wget
      unzip
      obsidian
      vlc
      haruna
      viewnior
      ntfs3g
      sbctl # create secure boot keys
      ghidra
      steam-run
    ];
  };

  # Catppuccin
  catppuccin = {
    flavor = "macchiato";
    accent = "rosewater";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable fontconfig
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Enable numlock at startup
  xsession.numlock.enable = true;

  home.file.".config/gtk/helpers.rc".text = ''
    TerminalEmulator=kitty
    TerminalEmulatorDismissed=true
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
