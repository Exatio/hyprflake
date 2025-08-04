# -----------------------------------------------------
# Animations
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {
    
    # TODO : check  JaKoolit animations
    /*animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    */

    animations = {
      enabled = true;
      bezier = [
        "shot, 0.2, 1.0, 0.2, 1.0"
        "swipe, 0.6, 0.0, 0.2, 1.05"
        "linear, 0.0, 0.0, 1.0, 1.0"
        "progressive, 1.0, 0.0, 0.6, 1.0"
      ];
      animation = [
        "windows, 1, 6, shot, slide"
        "workspaces, 1, 6, swipe, slide"
        "fade, 1, 4, progressive"
        "border, 1, 6, linear"
        "borderangle, 1, 180, linear, loop"
      ];
    };
  };

}




  
