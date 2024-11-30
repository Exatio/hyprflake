{ inputs, lib, pkgs, ... }:
{

  imports = [
    ./programs/git
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
      ghidra
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
        "application/x-extension-htm"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "application/x-extension-html"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "application/x-extension-shtml"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "application/x-extension-xht"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "application/x-extension-xhtml"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "application/xhtml+xml"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "text/html"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "x-scheme-handler/chrome"="userapp-Navigateur Mullvad-5BX1S2.desktop"; 
        "x-scheme-handler/http"="userapp-Navigateur Mullvad-5BX1S2.desktop";
        "x-scheme-handler/https"="userapp-Navigateur Mullvad-5BX1S2.desktop";
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

  # Enable numlock at startup
  xsession.numlock.enable = true;

  home.file.".config/gtk/helpers.rc".text = ''
    TerminalEmulator=kitty
    TerminalEmulatorDismissed=true
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
