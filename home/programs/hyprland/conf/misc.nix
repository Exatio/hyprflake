# -----------------------------------------------------
# Misc settings
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {

    misc = {
      # Disable default Hyprland background
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      # Enable Variable Refresh Rate when fullscreen (most likely gaming)
      vrr = 2;
      # Wake computer with mouse/keyboard press
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    binds = {
        # TODO: What does that do ?
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
    };

  };

}
