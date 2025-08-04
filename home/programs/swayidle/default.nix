{ pkgs, ... }:
{
  services.swayidle =
  let
    lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -fF";
    dpmsCommand = "${pkgs.hyprland}/hyprctl dispatch dpms";
  in
  {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "hyprland-session.target";
    timeouts = [
    {
        timeout = 295;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
    }
    {
        timeout = 300;
        command = lockCommand;
    }
    {
        timeout = 900;
        command = "${dpmsCommand} off";
        resumeCommand = "${dpmsCommand} on";
    }
    ];

    events = [
    {
        event = "before-sleep";
        command = lockCommand;
    }
    {
        event = "lock";
        command = lockCommand;
    }
    ];
  };
}
