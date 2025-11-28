{
  wayland.windowManager.hyprland.settings = {

    # -----------------------------------------------------
    # Bind workspaces to monitor
    # -----------------------------------------------------
    workspace = [
      "1, monitor:$internalM"
      "3, monitor:$internalM"
      "4, monitor:$internalM"
      "5, monitor:$internalM"

      "2, monitor:$externalM"
      "6, monitor:$externalM"
      "7, monitor:$externalM"
      "8, monitor:$externalM"
    ];

    
    # -----------------------------------------------------
    # General Window Settings
    # -----------------------------------------------------
    source = ["colors.conf" "hdw.conf"];

    general = {
      gaps_in = 3;
      gaps_out = 20;
      border_size = 2;
      
      "col.active_border" = "$primary_container $secondary_container 45deg"; #TODO : color1 color2 check if we wanna use theses ones
      "col.inactive_border" = "$background";

      layout = "dwindle";
      # layout = "master";
      # resize_on_border = true
    };

    # -----------------------------------------------------
    # Window rules
    # -----------------------------------------------------

    windowrule = [
      /* Decoration */
      "match:class .*, opacity 0.999"
      
      /* Launcher */
      "match:class ulauncher, stay_focused on, border_size 0"

      /* Floating Dialogs */
      "match:class ^$, float on"
      "match:title ^$, float on"

      "match:title ^(Save File)$, float on"
      "match:title ^(Save As)$, float on"
      "match:title ^(Open Folder)$, float on"
      "match:title ^(Open File)$, float on"

      "match:title ^(Picture-in-Picture)$, float on, size 800 450, pin on, opaque on"

      "match:class pavucontrol, float on, center on"

      "match:class .blueman-manager-wrapped, float on, center on"

      "match:class nm-connection-editor, float on"
      "match:class viewnior, float on"
      "match:class org.keepassxc.KeePassXC, float on"
      "match:class org.kde.polkit-kde-authentication-agent-1, float on"
      "match:class nwg-look, float on"
      "match:class qt5ct, float on"
      "match:class org.gnome.SystemMonitor, float on"

      /* Personal preferences */
      "match:class obsidian, workspace 2"
      "match:class vesktop, workspace 6 silent"
            
      # Plasmoids
      # "match:class org.kde.plasmawindowed, no_anim on, no_initial_focus on, float on, noborder on"
      # "match:class org.kde.plasmashell, float on"

    ];
  };

}
