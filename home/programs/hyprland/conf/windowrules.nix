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
      "tile,^(floorp)$"
      "float,^(pavucontrol)$"
      "float,^(blueman-manager)$"

      "float, nm-connection-editor|blueman-manager"
      "float, swayimg|Viewnior|pavucontrol"
      "float, nwg-look|qt5ct|mpv"
      "float, gnome-system-monitor"
      "float, dde-polkit-agent"

      "center,^(pavucontrol)"
    ];

    windowrulev2 = [
      "workspace 2, class:^(Obsidian)$"
      "workspace 6 silent, class:^(VencordDesktop)$"

      "opacity 0.9 0.7, class:^(chromium)$"
      "opacity 0.9 0.7, class:^(thunar)$"
    ];

  };

}
