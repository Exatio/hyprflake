# -----------------------------------------------------
# General window decoration
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {

    decoration = {
      rounding = 10;
      blur = {
          enabled = true;
          size = 10;
          passes = 3;
          ignore_opacity = true;
          xray = true;
      };
      active_opacity = 0.9;
      inactive_opacity = 0.8;
      fullscreen_opacity = 1.0;

      dim_inactive = true;
      dim_strength = 0.2;

      shadow = {
        range = 5;
        color = "rgba(1a1a1aee)";
      };

    };

    layerrule = [
      "blur, waybar"
      "blur, launcher"
      "blur, logout_dialog"
    ];
    
  };

}
