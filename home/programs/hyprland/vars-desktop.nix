{ inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$internalM" = "DP-1";
      "$externalM" = "DP-2";
      "$keyboardLayout" = "fr";
      "$scripts" = "/home/exatio/hyprflake/scripts";

      monitor = [
        "$internalM, 2560x1440@165, 0x0, 1"
        "$externalM, 1920x1080@60, -1920x360, 1"
      ];

    };
  };

}
