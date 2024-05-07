{ inputs, lib, pkgs, ... }:
{

  imports = [
    ./programs/git
    ./programs/gtk
    ./programs/code
    ./fonts

    ./desktops/hyprland.nix
  ];

  home = {
    username = "exatio";
    homeDirectory = "/home/exatio";
    packages = with pkgs; [
      # Web
      floorp
      firefox
      ungoogled-chromium

      # Discord
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      vesktop

      # Other
      cool-retro-term
      wget
      unzip
      obsidian
      vlc
      viewnior
      ntfs3g
    ];
  };

  # Catppuccin
  catppuccin.flavour = "macchiato";

  # User Directories
  xdg.userDirs =  {
    enable = true;
    createDirectories = true;
  };

  # Catppuccin theming
  xdg.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable fontconfig
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.file.".config/gtk/helpers.rc".text = ''
    TerminalEmulator=kitty
    TerminalEmulatorDismissed=true
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
