# -----------------------------------------------------
# Keyboard layout and mouse
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {

    input = {
      kb_layout = "$keyboardLayout";
      kb_variant = "";
      kb_model = "";
      kb_options = "grp:alt_shift_toggle";
      kb_rules = "";
      follow_mouse = 1;
      repeat_rate = 50;
      repeat_delay = 300;
      touchpad = {
          natural_scroll = false; # Inverts scrolling direction
      };
      scroll_method = "on_button_down";
      scroll_button = "274";
      sensitivity = -0.2; # -1.0 - 1.0, 0 means no modification.
      float_switch_override_focus = 0; # if 1, focus will change to window under cursor when tiling -> floating mode
    };

  };

}
