{ inputs, pkgs, ... }:
{
  # Special thanks to Stephan Raabe & JaKoolit for their Hyprland configs

  imports = [
    inputs.hyprland.homeManagerModules.default
    ./vars.nix
    ./conf/environment.nix
    ./conf/keyboard.nix
    ./conf/window.nix
    ./conf/decoration.nix
    ./conf/layouts.nix
    ./conf/misc.nix
    ./conf/keybindings.nix
    ./conf/windowrules.nix
    ./conf/animations-low.nix
    # ./conf/animations-high.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings = {

      debug = {
          disable_logs = false;
      };

      exec-once = [
        # Clipboard
        "wl-clip-persist --clipboard regular &"
        "wl-paste --watch cliphist store &"

        # Print notification if battery low
        "$scripts/battery_notification.sh &"

        # Start Waybar
        "$scripts/status_bar.sh &"

        # Wallpaper
        "swww kill; swww-daemon --format xrgb &"
        "$scripts/random_wallpaper.sh &"

        # Prevents swayidle from locking computer when not afk (audio running)
        "sway-audio-idle-inhibit"

        # Deepin Polkit
        "${pkgs.deepin.dde-polkit-agent}/lib/polkit-1-dde/dde-polkit-agent"

        # Gamma
        "wlsunset -t 4000 -T 6500 -d 900 -S 07:00 -s 19:00 &"
      ];

    };
  };

}



