{ pkgs, config, inputs, ...}:
{
  imports = [
    ../programs/hyprland

    ## All programs in my Hyprland desktop ##

    ../programs/alacritty
    ../programs/kitty

    ../programs/zsh

    ../programs/waybar
    ../programs/btop
    ../programs/tofi
    ../programs/screenshots
    ../programs/cava
    ../programs/pywal
    ../programs/swaylock
    ../programs/wlogout
    ../programs/dunst
    ../programs/swayidle

    ../../scripts/packages.nix

  ];


  home.packages = with pkgs; [
    kdeconnect
    wlsunset
    sway-audio-idle-inhibit
    blueman
    eww
    deepin.dde-polkit-agent
  ] ++ (with pkgs.xfce; [
    exo
    xfce4-settings
    xfce4-power-manager
  ]);



  services.blueman-applet.enable = true;
  services.kdeconnect.enable = true;
}


