{ inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$internalM" = "DP-1";
      "$externalM" = "HDMI-A-1";
      "$keyboardLayout" = "fr";
      "$scripts" = "/home/exatio/hyprflake/scripts";

      monitor = [
        "$internalM, 2560x1440@165, 0x0, 1"
        "$externalM, 2560x1440@60, -2560x0, 1"
      ];

    };
  };

}
