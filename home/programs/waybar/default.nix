{ pkgs, lib, isDesktop, ... }:
{
  home.packages = with pkgs; [
    waybar
    wttrbar
    pavucontrol

    nerd-fonts.jetbrains-mono
  ];

  home.file.".config/waybar/modules".source = ./modules;

  home.file.".config/waybar/bar".recursive = true;
  home.file.".config/waybar/bar".source = (if isDesktop then ./bar_d else ./bar_l);

  home.file.".config/waybar/bar2".recursive = true;
  home.file.".config/waybar/bar2".source = (if isDesktop then ./bar2_d else ./bar2_l);
  
}
