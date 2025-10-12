{pkgs, ...}:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 32;
  };

  gtk = {
    enable = true;

    /* I'd really love to use this theme but it makes all GTK windows opaque and thus disables the blur effect :(
    theme = {
      name = "Orchis-Dark-Nord";
      package = pkgs.orchis-theme.override {
        tweaks = [ "nord" ];
        border-radius = 15;
      };
    };
    */

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      #name = "Papirus-Dark";
      #package = pkgs.papirus-icon-theme;
      name = "Tela-circle"; #-dark or -light ?
      package = pkgs.tela-circle-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };

    gtk4.extraConfig = {
      Settings = ''
      gtk-cursor-theme-name=Bibata-Modern-Classic  
      '';
    };
  };

  qt = {
    enable = true;

    style = {
      name = "kvantum";
    };

    platformTheme = {
      name = "qt5ct";
    };
  };

  home.packages = with pkgs; [
    utterly-nord-plasma
  ];
  
  home.file.".config/Kvantum/Utterly-Nord".source = "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord";
  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
  [General]
  theme=Utterly-Nord
  '';
}