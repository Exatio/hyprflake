{ pkgs, ... }:
{

  home.packages = with pkgs; [

    brightnessctl
    acpi
    wl-clip-persist
    wl-clipboard-rs
    mpv
    playerctl
    pamixer
    awww
    jq

  ];

  services.cliphist = {
    enable = true;
    package = pkgs.cliphist;
    systemdTargets = "hyprland-session.target";
  };

}
