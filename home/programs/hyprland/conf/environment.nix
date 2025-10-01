# -----------------------------------------------------
# Environment Variables
# -----------------------------------------------------
{ pkgs, ... }:
{
  
  home.packages = with pkgs; [
    cantarell-fonts
  ];

  wayland.windowManager.hyprland.settings = {

    env = [
      # Enable logs
      # "HYPRLAND_LOG_WLR, 1"

      # Misc
      "GDK_BACKEND, wayland"
      "CLUTTER_BACKEND, wayland"

      # XDG
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_DESKTOP, Hyprland"
      "XDG_SESSION_TYPE, wayland"

      # QT pretty sure this is useless but im not sure
      "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
      "QT_QPA_PLATFORM, wayland;xcb"
      "QT_SCALE_FACTOR, 1"
      
      # TODO check below. is this really useful?
      "WLR_NO_HARDWARE_CURSORS, 1"
      "WLR_RENDERER_ALLOW_SOFTWARE, 1"
      # "WLR_RENDERER, vulkan"

      # reduce firefox cpu usage (hardware acceleration)  
      "MOZ_ENABLE_WAYLAND,1"
      # "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2" set dedicated GPU to run hyprland?
    ];

  };

}
