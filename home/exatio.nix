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
      mullvad-browser
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
      viewnior
      ntfs3g
      sbctl # create secure boot keys
    ];
  };

  # Catppuccin
  catppuccin = {
    flavor = "macchiato";
    accent = "rosewater";
  };

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
        "x-scheme-handler/http"="mullvad-browser.desktop";
        "x-scheme-handler/https"="mullvad-browser.desktop";
        "x-scheme-handler/chrome"="mullvad-browser.desktop";
        "text/html"="mullvad-browser.desktop";
        "application/x-extension-htm"="mullvad-browser.desktop";
        "application/x-extension-html"="mullvad-browser.desktop";
        "application/x-extension-shtml"="mullvad-browser.desktop";
        "application/xhtml+xml"="mullvad-browser.desktop";
        "application/x-extension-xhtml"="mullvad-browser.desktop";
        "application/x-extension-xht"="mullvad-browser.desktop";
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
