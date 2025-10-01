{ pkgs, config, inputs, ...}:
{
  imports = [
    ../programs/hyprland

    ## All programs in my Hyprland desktop ##

    ../programs/alacritty
    ../programs/kitty

    ../programs/zsh
    ../programs/gtk
    ../programs/waybar
    ../programs/btop
    ../programs/tofi
    ../programs/screenshots
    ../programs/cava
    ../programs/matugen
    ../programs/swaylock
    ../programs/wlogout
    ../programs/swayidle

    ../../scripts/packages.nix

  ];


  home.packages = with pkgs; [
    #plasma5Packages.kdeconnect-kde
    wlsunset
    sway-audio-idle-inhibit
    blueman
    eww
    kdePackages.polkit-kde-agent-1
  ] ++ (with pkgs.xfce; [
    thunar
    thunar-archive-plugin
    thunar-volman
    exo
    xfce4-settings
    xfce4-power-manager
  ]);

  services.blueman-applet.enable = true;
  services.kdeconnect.enable = true;
}


