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
    # Window rules
    # -----------------------------------------------------

    windowrule = [
      "tile,  class:mullvad-browser"
      "float, class:pavucontrol"
      "float, class:blueman-manager"

      "float, class:nm-connection-editor, class:blueman-manager"
      "float, class:swayimg, class:Viewnior, class:pavucontrol"
      "float, class:nwg-look, class:qt5ct, class:mpv"
      "float, class:gnome-system-monitor"
      "float, class:dde-polkit-agent"

      "center, class:pavucontrol"
      

      "workspace 2, class:Obsidian"
      "workspace 6 silent, class:vesktop"

      "opacity 0.9 0.7, class:mullvad-browser"
      "opacity 0.9 0.7, class:thunar"

    ];

  };

}
