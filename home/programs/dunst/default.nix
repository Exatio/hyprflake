{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libnotify
  ];


  catppuccin.dunst.enable = true;
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    settings = {

        global = {
            #frame_color = "#cdd6f4";
            #separator_color = "frame";
        };

        urgency_low = {
            # background = "#1e1e2e";
            #foreground = "#cdd6f4";
            timeout = "2";
           # icon = "~/hyprflake/assets/apps/dunst/notification.png";
        };

        urgency_normal = {
           # background = "#1e1e2e";
           # foreground = "#cdd6f4";
            #frame_color = "#2c2c2c";
            timeout = "5";
           # icon = "~/hyprflake/assets/apps/dunst/notification.png";
        };

        urgency_critical = {
            #background = "#131313";
            #foreground = "#f5cb42";
            #frame_color = "#f38ba8";
            timeout = "0";
           # icon = "~/hyprflake/assets/apps/dunst/notification.png";
        };
    };

  };

}
