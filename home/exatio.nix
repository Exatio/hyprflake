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
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        # Images
        "image/png"="viewnior.desktop";
        "image/jpg"="viewnior.desktop";
        "image/jpeg"="viewnior.desktop";

        # Links (browser)
        "x-scheme-handler/http"="floorp.desktop";
        "x-scheme-handler/https"="floorp.desktop";
        "x-scheme-handler/chrome"="floorp.desktop";
        "text/html"="floorp.desktop";
        "application/x-extension-htm"="floorp.desktop";
        "application/x-extension-html"="floorp.desktop";
        "application/x-extension-shtml"="floorp.desktop";
        "application/xhtml+xml"="floorp.desktop";
        "application/x-extension-xhtml"="floorp.desktop";
        "application/x-extension-xht"="floorp.desktop";
      };

    };

    configFile."mimeapps.list".force = true; 

  };

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
