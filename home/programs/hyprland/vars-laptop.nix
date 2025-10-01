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
        ",addreserved,-6,0,0,0"
        "$internalM, 1920x1080@60,     0x0, 1"
        "$externalM, 1920x1080@60, -1920x0, 1"
      ];

    };
  };

}
