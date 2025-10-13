{ inputs, pkgs, lib, isDesktop, ... }:
{
  # Special thanks to Stephan Raabe & JaKoolit for their Hyprland configs

  imports = [
    inputs.hyprland.homeManagerModules.default
    ./conf/environment.nix
    ./conf/keyboard.nix
    ./conf/window.nix
    ./conf/decoration.nix
    ./conf/layouts.nix
    ./conf/misc.nix
    ./conf/keybindings.nix
    ./conf/animations-low.nix
    # ./conf/animations-high.nix

  ] ++ (if isDesktop then [
    ./vars-desktop.nix
  ] else [
    ./vars-laptop.nix
  ]);

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    plugins = [
      inputs.hypr-darkwindow.packages.${pkgs.system}.Hypr-DarkWindow
    ];
    settings = {

      debug.disable_logs = false;

      exec-once = [

        # Start Mullvad, then Discord
        "$scripts/mullvad_toggle.sh && vesktop &"

        # Clipboard
        "wl-clip-persist --clipboard regular &"
        "wl-paste --watch cliphist store &"

        # Start Waybar
        "$scripts/status_bar.sh &"

        # Wallpaper
        "swww kill; swww-daemon --format xrgb && $scripts/random_wallpaper.sh &"

        # Prevents swayidle from locking computer when not afk (audio running)
        "sway-audio-idle-inhibit &"

        # Gamma
        "wlsunset -t 5000 -T 6500 -d 900 -S 07:00 -s 21:00 &"

        # KDE Polkit
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &"

      ] ++ (if isDesktop then [
        
      ] else [ # Below is applied only on laptop
        # Print notification if battery low
        "$scripts/battery_notification.sh &"
      ]);

    };
  };

}



