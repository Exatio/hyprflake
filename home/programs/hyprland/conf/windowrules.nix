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
      "nodim, fullscreen:1"
      "tile,  class:^(firefox)$"

      "float, class:^(.*pavucontrol)$"
      "center, class:^(.*pavucontrol)$"

      "float, class:^(blueman-manager)$"

      "float, class:^(nm-connection-editor)$"
      "float, class:^(swayimg)$"
      "float, class:^(viewnior)$"
      "float, class:^(nwg-look)$"
      "float, class:^(qt5ct)$"
      "float, class:^(mpv)$"
      "float, class:^(.*SystemMonitor)$"
      "float, class:^(dde-polkit-agent)$"

      "workspace 2, class:^(obsidian)$"
      "float, title:^(Obsidian)$"

      "workspace 6 silent, class:^(vesktop)$"
    ];

  };

}
