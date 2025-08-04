{ pkgs, ... }:
{
  home.file.".config/wlogout/style.css".source = ./style.css; 
  home.file.".config/wlogout/style_1.css".source = ./style_1.css; 
  home.file.".config/wlogout/icons/.keep".text = ""; 
  home.file.".config/wlogout/icons" = {
    recursive = true;
    source = ./icons;
  };

  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;
    layout = [

      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }

      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }

      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout";
        keybind = "e";
      }

      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
 
    ];
  };
}
