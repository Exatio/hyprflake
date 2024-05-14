{ inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$internalM" = "eDP-1";
      "$externalM" = "DP-1";
      "$keyboardLayout" = "fr";
      "$scripts" = "/home/exatio/hyprflake/scripts";

      monitor = [
        "$internalM, 1920x1080@60,     0x0, 1"
        "$externalM, 1920x1080@60, -1920x0, 1"
      ];

    };
  };

}
