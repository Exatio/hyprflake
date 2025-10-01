# -----------------------------------------------------
# General window decoration
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {
    
    decoration = {
      rounding = 10;

      blur = {
          enabled = true;
          size = 3;
          passes = 3;
          xray = true;
      };

      shadow = {
        enabled = true;
        range = 8;
        render_power = 3;
        color = "rgba(000000D6)";
      };
    };

    layerrule = [
      "blur, waybar"
      "blur, launcher"
      "blur, logout_dialog"

      "blur, swaync-control-center"
      "blur, swaync-notification-window"
      "noanim, swaync-control-center"
    ];

  };

}
