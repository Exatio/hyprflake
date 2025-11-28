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
      "match:class waybar, blur on"
      "match:class logout_dialog, blur on"

      "match:class swaync-control-center, blur on, no_anim on"
      "match:class swaync-notification-window, blur on"
    ];

  };

}
