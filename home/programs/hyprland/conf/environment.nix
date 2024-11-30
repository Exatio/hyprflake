# -----------------------------------------------------
# Environment Variables
# -----------------------------------------------------
{ pkgs, ... }:
{
  
  home.packages = with pkgs; [
 #   dracula-qt5-theme
    adwaita-qt
    adwaita-qt6
    gnome.gnome-themes-extra
    gtk-engine-murrine
    sassc
    orchis
    cantarell-fonts
    bibata-cursors
    catppuccin-kvantum
  ];

  wayland.windowManager.hyprland.settings = {

    env = [
      # Enable logs
      # "HYPRLAND_LOG_WLR, 1"

      # Theme
      "XCURSOR_THEME, Bibata-Modern-Classic"
      "XCURSOR_SIZE, 24"
      "GTK_THEME, Orchis-Dark-Compact"

      # Misc
      "GDK_BACKEND, wayland"
      "CLUTTER_BACKEND, wayland"

      # XDG
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_DESKTOP, Hyprland"
      "XDG_SESSION_TYPE, wayland"

      # QT
      "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
      "QT_QPA_PLATFORM, wayland;xcb"
      "QT_QPA_PLATFORMTHEME, qt5ct"
      "QT_SCALE_FACTOR, 1"
      "QT_STYLE_OVERRIDE, kvantum-dark"
      
      # TODO check below

      "WLR_NO_HARDWARE_CURSORS, 1"
      "WLR_RENDERER_ALLOW_SOFTWARE, 1"

      # "WLR_RENDERER, vulkan"

      "MOZ_ENABLE_WAYLAND,1"
      # "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2" GPU to dedicated ?
    ];

  };

}
