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
      # layout = master
      # resize_on_border = true
    };

    # -----------------------------------------------------
    # Window rules
    # -----------------------------------------------------
    windowrule = [
      
      /* Decoration */
      "opacity 0.999, class:.*"
      "opacity 0.70, class:thunar"
      "forcergbx, title:Picture-in-Picture"

      /* Launcher */
      # noborder, class:ulauncher
      "stayfocused, class:ulauncher" #i will do this one day...

      /* Floating Dialogs/Programs */
      "float, class:^$,title:^$" # matches empty string class/title

      "float, title:^(Save File)$"
      "float, title:^(Save As)$"
      "float, title:^(Open Folder)$"
      "float, title:^(Open File)$"

      "float, title:^(Picture-in-Picture)$"
      "size 800 450, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      
      "float, class:pavucontrol"
      "center, class:pavucontrol"  
      
      "float, class:.blueman-manager-wrapped"
      "center, class:.blueman-manager-wrapped"

      "float, class:nm-connection-editor"
      "float, class:viewnior"
      "float, class:org.keepassxc.KeePassXC"  
      "float, class:org.kde.polkit-kde-authentication-agent-1"
      "float, class:nwg-look"
      "float, class:qt5ct"
      "float, class:org.gnome.SystemMonitor"

      /* My stuff */
      "workspace 2, class:^(obsidian)$"
      "workspace 6 silent, class:^(vesktop)$"

      /* TODO: see
    
      # Plasmoids
      windowrulev2 = noanim, class:org.kde.plasmawindowed
      windowrulev2 = noinitialfocus, class:org.kde.plasmawindowed
      windowrulev2 = float, class:org.kde.plasmawindowed
      windowrulev2 = float, class:org.kde.plasmashell
      # windowrulev2 = noborder, class:org.kde.plasmawindowed

      */
    ];

  };

}
