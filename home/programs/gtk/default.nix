{ pkgs, ... }:
{

  home.packages = with pkgs; [
    nwg-look
    qt5ct
    catppuccin-qt5ct
    lxappearance
  ];


  # Also see hyprland config

  gtk = {
    enable = true;

    font = {
      name = "Cantarell";
      size = 11;
      package = pkgs.cantarell-fonts;
    };

    cursorTheme = {
      # name = "Bibata-Modern-Ice";
      name = "Bibata-Modern-Classic";
      size = 24;
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      # name = "Vivid-Dark-Icons";
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    catppuccin = {
      enable = true;
      accent = "teal";
      size = "standard";
      tweaks = [ "normal" ];
      cursor = {
        enable = false;
        accent = "teal";
        flavour = "macchiato";
      };
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

  };

}

