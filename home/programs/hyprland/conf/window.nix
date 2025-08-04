# -----------------------------------------------------
# General window layout and colors
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {

    source = "colors.conf";

    general = {
      gaps_in = 3;
      gaps_out = 6;
      border_size = 3;
      
      # TODO: use colors.conf to make hyprland pretty :)

      # "col.active_border" = "$color11 rgba(59595900) $color14 45deg"; # Pywal
      # "col.active_border" = "rgb(8839ef) rgb(cba6f7) rgb(ca9ee6) rgb(c6a0f6) 45deg"; # Purple
      # "col.active_border" = "rgb(7287fd) rgb(74c7ec) rgb(89b4fa) 45deg"; # Blue

      # "col.inactive_border" = "rgba(59595950)";

      layout = "dwindle";
      # layout = master
      # resize_on_border = true
    };

  };

}
