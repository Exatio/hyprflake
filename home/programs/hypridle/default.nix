{ pkgs, ... }:
{
  services.hypridle = 
  let
    lockCommand = "swaylock -fF";
    dpmsCommand = "hyprctl dispatch dpms";
    notifyCommand = "notify-send";
  in
  {
    enable = true;
    package = pkgs.hypridle;
    systemdTarget = "hyprland-session.target";

    settings = {
      general = {
        lock_cmd = "${lockCommand}";

        on_unlock_cmd = "${notifyCommand} 'Welcome Back !' -t 3000";

        after_sleep_cmd = "${dpmsCommand} on";
      };

      listener = [
        {
          timeout = 295;
          on-timeout = "${notifyCommand} 'Locking in 5 seconds' -t 5000";
        }
        {
          timeout = 300;
          on-timeout = "${lockCommand}";
        }
        {
          timeout = 480;
          on-timeout = "sleep 1 && ${dpmsCommand} off";
          on-resume = "${dpmsCommand} on";
        }
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];

    };

  };
}
